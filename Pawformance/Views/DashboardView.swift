//
//  DashboardView.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/29/25.
//

import SwiftUI
import OpenAI

struct DashboardView: View {
    @State private var goalProgress = 0.0
    @State private var totalSteps: String = "0"
    @State private var caloriesBurned: String = "0"
    @State private var activeMinutes: String = "0"
    @State private var caloriesConsumed: String = "0"
    @State private var goalsAchieved = 0
    @State private var healthScore: String = ""
    @State private var goals: [GoalCard] = []
    @State private var showEditView = false
    @State private var showEditMenu = false
    @State private var showNewGoalMenu = false
    @State private var newGoalDescription = ""
    @State private var newGoalValue = ""
    @State private var petType: String = ""
    @State private var petName: String = ""
    private var openAIService = OpenAIService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header Section
                HStack(spacing:50){
                    NavigationLink(destination: EditGoalsView(totalSteps: $totalSteps, caloriesBurned: $caloriesBurned, activeMinutes: $activeMinutes, caloriesConsumed: $caloriesConsumed, healthScore: $healthScore, goals: $goals, showEditView: $showEditView, showEditMenu: $showEditMenu, showNewGoalMenu: $showNewGoalMenu)) {
                        Image(systemName:"plus.circle.fill")
                            .frame(width: 50, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        // Home action
                    }) {
                        Image(systemName:"house.fill")
                            .frame(width: 50, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: SettingsView(petType: $petType, petName: $petName)){
                        Image(systemName:"gearshape.fill")
                            .frame(width: 50, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: ChatView()) {
                        Image(systemName:"message.fill")
                            .frame(width: 50, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                .frame(height: 60)
                
                Text("\(petName)'s Pawformance")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                
                // Metrics Grid
                HStack(spacing: 15) {
                    MetricCard(title: "Total Distance", value: "\(totalSteps) mi", icon: "pawprint.fill", color: .yellow)
                    MetricCard(title: "Calories Burned", value: "\(caloriesBurned) kcal", icon: "flame.fill", color: .orange)
                }
                
                HStack(spacing: 15) {
                    MetricCard(title: "Active Minutes", value: "\(activeMinutes)", icon: "timer", color: .green)
                    MetricCard(title: "Consumed", value: "\(caloriesConsumed) kcal", icon: "bolt.fill", color: .blue)
                }
                
                HStack(spacing: 15) {
                    MetricCard(title: "Goals Achieved", value: "\(goalsAchieved)", icon: "checkmark.seal.fill", color: .purple)
                    MetricCard(title: "Health Score", value: "\(healthScore)/10", icon: "heart.fill", color: .red)
                }
                .onAppear {
                    getHealthScore()
                }
                .padding(.bottom, 30)
                Divider()
                ScrollView(.vertical) {
                    // Progress Bar
                    VStack(alignment: .leading) {
                        Text("Progress")
                            .font(.headline)
                            .padding(.top, 5)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 20)
                        
                        ProgressView(value: goalProgress, total: 100)
                            .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                            .padding(.horizontal, 20)
                            .frame(height: 20)
                    }
                    
                    // Goal Cards
                    ForEach(goals.indices, id: \.self) { index in
                        GoalCard(title: goals[index].title,
                                 value: goals[index].value,
                                 icon: goals[index].icon,
                                 color: goals[index].color)
                        .onAppear {
                            checkGoals()
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(maxHeight: .infinity)  // Ensures scrolling is enabled when content overflows
            }
        }
    }
    
    func checkGoals() {
        var achievedCount = 0
        goals.removeAll { goal in
            let goalValue = Int(goal.value.components(separatedBy: " ").first ?? "") ?? 0
            
            // Check if goal is achieved based on different metrics
            switch goal.title {
            case "Minutes Goal":
                if let activeMinutesInt = Int(activeMinutes), activeMinutesInt >= goalValue {
                    achievedCount += 1
                    return true
                }
            case "Distance Goal":
                if let totalStepsInt = Int(totalSteps), totalStepsInt >= goalValue {
                    achievedCount += 1
                    return true
                }
            case "Burned Goal":
                if let caloriesBurnedInt = Int(caloriesBurned), caloriesBurnedInt >= goalValue {
                    achievedCount += 1
                    return true
                }
            case "Consumed Goal":
                if let caloriesConsumedInt = Int(caloriesConsumed), caloriesConsumedInt >= goalValue {
                    achievedCount += 1
                    return true
                }
            default:
                return false
            }
            return false
        }
        
        // Increment goalsAchieved and update goalProgress
        if achievedCount > 0 {
            self.goalsAchieved = (goalsAchieved + Int(Double(achievedCount)))
            updateProgress()
        }
    }
    
    func updateProgress() {
        let totalGoals = goals.count + (Int(goalsAchieved))
        if totalGoals > 0 {
            goalProgress = (Double(Int(goalsAchieved)) / Double(totalGoals)) * 100
        } else {
            goalProgress = 100.0
        }
    }
    
    func getHealthScore() {
        // Convert the metrics to numeric values
        guard let totalStepsInt = Int(totalSteps), let caloriesBurnedInt = Int(caloriesBurned), let activeMinutesInt = Int(activeMinutes), let caloriesConsumedInt = Int(caloriesConsumed) else {
            // If any metric is not a valid number, return early
            healthScore = "N/A"
            return
        }

        // Define the max values for normalization
        let maxSteps = 10 // max miles
        let maxCaloriesBurned = 3000 // max recommended calories burned
        let maxActiveMinutes = 420 // Example: Maximum recommended active minutes
        let maxCaloriesConsumed = 5000
        // Normalize each metric on a scale from 0 to 100
        let normalizedSteps = min(Double(totalStepsInt) / Double(maxSteps) * 100, 100)
        let normalizedCaloriesBurned = min(Double(caloriesBurnedInt) / Double(maxCaloriesBurned) * 100, 100)
        let normalizedActiveMinutes = min(Double(activeMinutesInt) / Double(maxActiveMinutes) * 100, 100)
        let normalizedCaloriesConsumed = min(Double(caloriesConsumedInt) / Double(maxCaloriesConsumed) * 100, 100)

        // Assign weights to each metric
        let weightSteps = 0.25
        let weightCaloriesBurned = 0.25
        let weightActiveMinutes = 0.25
        let weightCaloriesConsumed = 0.25

        // Calculate the weighted average to get the health score (out of 100)
        let weightedScore = (normalizedSteps * weightSteps) +
                            (normalizedCaloriesBurned * weightCaloriesBurned) +
                            (normalizedActiveMinutes * weightActiveMinutes) +
                            (normalizedCaloriesConsumed * weightCaloriesConsumed)

        // Convert the score from a scale of 0-100 to 1-10
        let healthScoreValue = (weightedScore / 10).rounded()

        // Set the health score
        healthScore = "\(Int(healthScoreValue))"
    }
}

// Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

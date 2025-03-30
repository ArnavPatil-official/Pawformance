//
//  DashboardView.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/29/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var goalProgress = 0.0
    @State private var totalSteps: String = "0"
    @State private var caloriesBurned: String = "0"
    @State private var activeMinutes: String = "0"
    @State private var caloriesConsumed: String = "0"
    @State private var goalsAchieved = 0
    @State private var healthScore: String = "0"
    @State private var goals: [GoalCard] = []
    @State private var showEditView = false
    @State private var showEditMenu = false
    @State private var showNewGoalMenu = false
    @State private var newGoalDescription = ""
    @State private var newGoalValue = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Section
                    HStack(spacing:50){
                        NavigationLink(destination:EditGoalsView(totalSteps: $totalSteps, caloriesBurned: $caloriesBurned, activeMinutes: $activeMinutes, caloriesConsumed: $caloriesConsumed, healthScore: $healthScore, goals: $goals, showEditView: $showEditView, showEditMenu: $showEditMenu, showNewGoalMenu: $showNewGoalMenu)) {
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
                        Button(action: {
                            // Profile action
                        }) {
                            Image(systemName:"gearshape.fill")
                                .frame(width: 50, height: 50)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            // Profile action
                        }) {
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
                    Text("PAWFORMANCE")
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
                    .padding(.bottom, 30)
                    Divider()
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
    
}

// Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

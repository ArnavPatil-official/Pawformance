//
//  Components.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/29/25.
//

import SwiftUI
//import Observation
//@Observable
//class DashboardData {
//    var totalSteps: Int
//    var caloriesBurned: Int
//    var activeMinutes: Int
//    var caloriesConsumed: Int
//    var goalsAchieved: Int
//    var healthScore: Int
//    var goals: [GoalCard]
//
//    init(totalSteps: Int = 0, caloriesBurned: Int = 0, activeMinutes: Int = 0, caloriesConsumed: Int = 0, goalsAchieved: Int = 0, healthScore: Int = 0, goals: [GoalCard] = []) {
//        self.totalSteps = totalSteps
//        self.caloriesBurned = caloriesBurned
//        self.activeMinutes = activeMinutes
//        self.caloriesConsumed = caloriesConsumed
//        self.goalsAchieved = goalsAchieved
//        self.healthScore = healthScore
//        self.goals = goals
//    }
//}


struct MetricCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .frame(width: 150, height: 120)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}
struct EditableCard: View {
    var title: String
    var icon: String
    var color: Color
    @Binding private var value: String
    init(title: String, icon: String, color: Color, value: Binding<String>) {
            self.title = title
            self.icon = icon
            self.color = color
            self._value = value
        }
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            TextField("", text: $value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .frame(width: 150, height: 120)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

struct GoalCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .frame(width: 320, height: 120)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

func editGoal(value: Int, goal: String) -> GoalCard {
    let newGoal: GoalCard
    
    switch value {
    case 1:
        newGoal = GoalCard(title: "Minutes Goal", value: "\(goal) min", icon: "timer", color: .green)
    case 2:
        newGoal = GoalCard(title: "Distance Goal", value: "\(goal) mi", icon: "pawprint.fill", color: .yellow)
    case 3:
        newGoal = GoalCard(title: "Burned Goal", value: "\(goal) kcal", icon: "flame.fill", color: .orange)
    case 4:
        newGoal = GoalCard(title: "Consumed Goal", value: "\(goal) kcal", icon: "bolt.fill", color: .blue)
    default:
        newGoal = GoalCard(title: "", value: "", icon: "", color: .gray)
    }
    
    return newGoal
    
}


import SwiftUI

struct EditGoalsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var totalSteps: String
    @Binding var caloriesBurned: String
    @Binding var activeMinutes: String
    @Binding var caloriesConsumed: String
    @Binding var healthScore: String
    @Binding var goals: [GoalCard]
    @Binding var showEditView: Bool
    @Binding var showEditMenu: Bool
    @Binding var showNewGoalMenu: Bool
    @State var goalValue = ""
    @State var goalType = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Edit")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                // Goal description field
                VStack {
                    Menu("Goal Type") {
                        Button(action: {
                            goalType = 1
                        }) {
                            Text("Minutes")
                        }
                        Button(action: {
                            goalType = 2
                        }) {
                            Text("Distance")
                        }
                        Button(action: {
                            goalType = 3
                        }) {
                            Text("Calories Burned")
                        }
                        Button(action: {
                            goalType = 4
                        }) {
                            Text("Calories Consumed")
                        }
                    }
                    .bold()
                    .frame(width: 150, height: 25)
                    .foregroundStyle(.white)
                    .background(Color.blue.opacity(1))
                    .cornerRadius(10)
                    TextField("Enter goal value", text: $goalValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        goals.append(editGoal(value: goalType, goal: goalValue))
                        
                    }) {
                        Text("Add")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    Divider()
                    Text("Edit Metrics")
                        .font(.caption)
                        .padding()
                    HStack(spacing: 15) {
                        EditableCard(title: "Total Distance", icon: "pawprint.fill", color: .yellow, value: $totalSteps)
                        EditableCard(title: "Calories Burned", icon: "flame.fill", color: .orange, value: $caloriesBurned)
                    }
                    
                    HStack(spacing: 15) {
                        EditableCard(title: "Active Minutes", icon: "timer", color: .green, value: $activeMinutes)
                        EditableCard(title: "Consumed", icon: "bolt.fill", color: .blue, value: $caloriesConsumed)
                    }
                    .padding(.bottom, 30)
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Save")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding()
//                .onAppear {
//                    updateInputsFromDashboard()
//                }
            }
            
            
        }
    }
//    func updateInputsFromDashboard() {
//        distanceInput = "\(dashboardData.totalSteps)"
//        burnedInput = "\(dashboardData.caloriesBurned)"
//        activeInput = "\(dashboardData.activeMinutes)"
//        consumedInput = "\(dashboardData.caloriesConsumed)"
//    }
//    
//    func saveChanges() {
//        dashboardData.totalSteps = Int(distanceInput) ?? 0
//        dashboardData.caloriesBurned = Int(burnedInput) ?? 0
//        dashboardData.activeMinutes = Int(activeInput) ?? 0
//        dashboardData.caloriesConsumed = Int(consumedInput) ?? 0
//    }
}
    
struct EditGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        EditGoalsView(totalSteps: .constant("0"), caloriesBurned: .constant("0"), activeMinutes: .constant("0"), caloriesConsumed: .constant("0"), healthScore: .constant("0"), goals: .constant([]), showEditView: .constant(false), showEditMenu: .constant(false), showNewGoalMenu: .constant(false)
                      )
    }
}

//
//  Settings.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/30/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var petType: String
    @Binding var petName: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pet Information")) {
                    TextField("Pet Type", text: $petType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Pet Name", text: $petName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                }
                
                Section {
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
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func saveSettings() {
        // Settings are automatically saved with @AppStorage
        print("Settings saved: \(petType), \(petName)")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(petType: .constant(""), petName: .constant(""))
    }
}

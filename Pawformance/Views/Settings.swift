//
//  Settings.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/30/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var petType = ""
    @State private var petName = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Settings")
                TextField("Type of pet", text: $petType)
                    .frame(width: 300, height: 50)
                    .border(Color.gray.opacity(0.3))
                TextField("Name of pet", text: $petName)
                    .frame(width: 300, height: 50)
                    .border(Color.gray.opacity(0.3))
                
            }
        }
    }
}
struct Settings_preview: PreviewProvider {
    static var previews: some View {
            SettingsView()
    }
}

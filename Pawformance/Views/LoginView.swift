//
//  LoginView.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/29/25.
//

import SwiftUI
import Supabase

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App Logo
                //            Image("capitasimple")
                //                .resizable()
                //                .scaledToFit()
                //                .frame(width: 200, height: 200)
                //                .padding(.top, 40)
                Text("Pawformance")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(.blue)
                    .padding(.top,200)
                    .italic(false)
                // Username Field
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal, 30)
                    .border(.red, width: CGFloat(wrongUsername))
                
                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal, 30)
                    .border(.red, width: CGFloat(wrongPassword))
                
                // Login Button
                Button(action: {
                    // authentication
                    
                }) {
                    Text("Log In")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }
                NavigationLink(destination: ContentView()) {
                    EmptyView() // Invisible link that triggers when authenticated
                    }
                
                //            Button(action: {
                //                // Handle login action here
                //            }) {
                //                Text("Google Sign In")
                //                    .fontWeight(.light)
                //                    .frame(maxWidth: .infinity, minHeight: 50)
                //                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(1), lineWidth: 1))
                //                    .background(Color.white)
                //                    .foregroundColor(.black)
                //                    .cornerRadius(10)
                //                    .padding(.horizontal, 30)
                //            }
                
                // Sign Up and Forgot Password
                HStack {
                    Button("Sign Up") {
                        // Handle Sign Up
                    }
                    .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button("Forgot Password?") {
                        // Handle Forgot Password
                    }
                    .foregroundColor(.blue)
                }
                .padding(.horizontal, 30)
                .font(.system(size: 14))
                
                Spacer()
            }
            .padding()
        }
    }
    func authenticateUser(username: String, password: String) {
        // Supabase
    }
}

#Preview {
    LoginView()
}

//
//  Chatbot.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/30/25.
//

import SwiftUI

struct ChatbotView: View {
    @State private var messages: [String] = []
    @State private var userMessages: [String] = []
    @State private var userMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Chat message list
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.self) { message in
                            HStack {
                                    Text(message)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal)
                        }
                        ForEach(userMessages,id: \.self) {userMessage in
                            HStack {
                                Text(userMessage)
                                    .padding()
                                    .background(Color.blue.opacity(0.4))
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 10)

                // Text input and send button
                HStack {
                    TextField("Type your message", text: $userMessage)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.leading, 10)
                        .frame(width: 300, height: 50, alignment: .center)

                    Button(action: {
                        sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                            .padding(10)
                    }
                    .padding(.trailing, 10)
                }
                .background(Color.white)
                .padding(.bottom, 20)
                .shadow(radius: 5)
            }
            .navigationBarTitle("Pawformance Trainer", displayMode: .inline)
        }
    }
    
    func sendMessage() {
        guard !userMessage.isEmpty else { return }
        
        userMessages.append(userMessage)
        
        userMessage = ""
        
    }
}

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}

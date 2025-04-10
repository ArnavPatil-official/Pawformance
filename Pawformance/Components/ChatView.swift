//
//  ChatView.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/30/25.
//

import Foundation
extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        @Published var currentInput: String = ""
        private let openAIService = OpenAIService()
        
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            Task  {
                let response = await openAIService.sendMessage(messages: messages)
                guard let recieveOpenAIMessage = response?.choices.first?.message else {
                    print("No response")
                    return
                }
                let recievedMessage = Message(id: UUID(), role: recieveOpenAIMessage.role, content: recieveOpenAIMessage.content, createAt: Date())
                await MainActor.run {
                    messages.append(recievedMessage)
                }
            }
        }
    }
}

struct Message: Decodable {
    let id: UUID
    let role: SenderRole 
    let content: String
    let createAt: Date
}

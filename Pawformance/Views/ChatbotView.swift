//
//  ChatbotView.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/30/25.
//

import SwiftUI
import OpenAI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}), id: \Message.id) { message in
                    messageView(message: message)
                }
            }
                HStack {
                    TextField("Enter a Message", text: $viewModel.currentInput)
                    Button("Send") {
                        viewModel.sendMessage()
                    }
                }
            
        }
    }
    func messageView(message: Message ) -> some View {
        HStack {
            if message.role == .user {Spacer()}
            Text(message.content)
            if message.role == .assistant {Spacer()}
        }
    }
}

 

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

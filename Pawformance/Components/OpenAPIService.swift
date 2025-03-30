//
//  OpenAIService.swift
//  Pawformance
//
//  Created by Arnav Patil on 3/30/25.
//

import Foundation
import Alamofire

class OpenAIService {
    private let endpointUrl = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let OpenAIMessages = messages.map({ OpenAIChatMessage(role: $0.role, content: $0.content) })
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: OpenAIMessages)
        
        let headers: HTTPHeaders = ["Authorization": "Bearer YOUR_API_KEY"]

        do {
            let response = try await AF.request(endpointUrl, method: .post, parameters: body, encoder: .json, headers: headers)
                .serializingDecodable(OpenAIChatResponse.self)
                .value
            
            return response
            
        } catch {
            print("Error sending message: \(error.localizedDescription)")
            return nil
        }
    }

}
struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}
struct OpenAIChatMessage: Codable{
    let role: SenderRole
    let content: String
}
enum SenderRole: String, Codable {
    case system
    case user
    case  assistant
}
struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}
struct OpenAIChatChoice: Decodable {
     let message: OpenAIChatMessage
}

//
//  ContentView.swift
//  GeminiAI
//
//  Created by R95 on 05/06/24.
//

import GoogleGenerativeAI
import SwiftUI

struct ContentView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State private var userPrompt = ""
    @State private var response = "How Can I Help You Today?"
    @State private var isLoading = false
    @State private var searchHistory = [SearchEntry]()
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HistoryView(searchHistory: $searchHistory)) {
                    VStack {
                        Text("History")
                            .padding(.leading, 300)
                    }
                }
                
                Text("Gemini AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.indigo)
                    .padding(.top, 40)
                
                ZStack {
                    ScrollView {
                        Text(response)
                    }
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                    }
                }
                
                ZStack {
                    HStack {
                        CustomTextField(placeholder: "Ask Anything", text: $userPrompt, isEditing: $isEditing)
                            .lineLimit(100)
                            .padding()
                            .background(Color.indigo.opacity(0.2))
                            .cornerRadius(20)
                            .frame(height: 60)
                            .disableAutocorrection(true)
                            .onSubmit {
                                generateResponse()
                            }
                        
                        Button(action: generateResponse) {
                            Text("Send")
                                .padding()
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            .navigationBarHidden(true)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    func generateResponse() {
        isLoading = true
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                let newResponse = result.text ?? "No Response Found"
                response = newResponse
                
                let entry = SearchEntry(prompt: userPrompt, response: newResponse, date: Date())
                searchHistory.append(entry)
                userPrompt = ""
            } catch {
                isLoading = false
                response = "Something Went Wrong: \(error.localizedDescription)"
            }
        }
    }
}

struct SearchEntry: Identifiable {
    let id = UUID()
    let prompt: String
    let response: String
    let date: Date
}

struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    @Binding var isEditing: Bool
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if isEditing {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isEditing: $isEditing)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isEditing: Bool
        
        init(text: Binding<String>, isEditing: Binding<Bool>) {
            _text = text
            _isEditing = isEditing
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                isEditing = true
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                isEditing = false
            }
        }
    }
}

#Preview {
    ContentView()
}

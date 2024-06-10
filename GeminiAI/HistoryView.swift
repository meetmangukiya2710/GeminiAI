//
//  HistoryView.swift
//  GeminiAI
//
//  Created by R95 on 10/06/24.
//

import SwiftUI

struct HistoryView: View {
    @Binding var searchHistory: [SearchEntry]
    
    var body: some View {
        VStack {
            List(searchHistory) { entry in
                VStack(alignment: .leading) {
                    Text(entry.prompt)
                        .font(.headline)
                    Text(entry.response)
                        .font(.subheadline)
                    Text(entry.date, style: .date)
                        .font(.caption)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Search History")
            
            Button(action: shareHistory) {
                Text("Share History")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func shareHistory() {
        let historyText = searchHistory.map { entry in
            """
            Prompt: \(entry.prompt)
            Response: \(entry.response)
            Date: \(entry.date)
            """
        }.joined(separator: "\n\n")
        
        let activityViewController = UIActivityViewController(activityItems: [historyText], applicationActivities: nil)
        
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}

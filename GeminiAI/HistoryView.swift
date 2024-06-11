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
                        .font(.footnote)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Search History")
        }
    }
}

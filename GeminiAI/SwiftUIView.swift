//
//  SwiftUIView.swift
//  GeminiAI
//
//  Created by R95 on 10/06/24.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var progress = 0.0
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 300,height: 180)
                
                ZStack {
                    ProgressView(value: progress)
                        .padding()
                        .padding(.top, 50)
                        .accentColor(.blue)
                        .onAppear {
                            startProgress()
                        }
                }
                NavigationLink(destination: LoginPage().navigationBarBackButtonHidden(true), isActive: $shouldNavigate) {}
            }
            .onAppear() {
                DBHelper.creatFile()
            }
        }
    }
    
    func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if self.progress < 1.0 {
                self.progress += 0.001
                print("true")
            } else {
                print("fasle")
                timer.invalidate()
                shouldNavigate = true
            }
        }
    }
}

#Preview {
    SwiftUIView()
}

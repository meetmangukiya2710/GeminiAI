//
//  LoginPage.swift
//  GeminiAI
//
//  Created by R95 on 12/06/24.
//

import SwiftUI

struct LoginPage: View {
    
    @State var arr = [UserData]()
    @State private var email = ""
    @State private var password = ""
    @State private var shouldNavigate = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200,height: 110)
                    .padding(.bottom, 50)
                
                Text("Sign Ip")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue .opacity(0.9))
                    .padding(.bottom, 50)
                
                TextField("Email", text: $email)
                    .cornerRadius(5)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 56)
                
                SecureField("Password", text: $password)
                    .cornerRadius(5)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 56)
                    .padding(.bottom, 50)
                
                if email.isEmpty && password.isEmpty {
                    
                } else {
                    let isAuthenticated = arr.contains { $0.email == email && $0.password == password }
                    if isAuthenticated {
                        NavigationLink("Sign In", destination: ContentView())
                            .padding()
                    } else {
                        
                    }
                }
                
                NavigationLink("I Have Don't Account", destination: RegistrationPage())
                    .padding()
            }
            .onAppear(){
                DBHelper.getData()
                arr = DBHelper.userArray
                print(arr)
            }
        }
    }
}

#Preview {
    LoginPage()
}

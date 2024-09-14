//
//  RegistrationPage.swift
//  GeminiAI
//
//  Created by R95 on 12/06/24.
//

import SwiftUI

struct RegistrationPage: View {
    
    @State private var fstName = ""
    @State private var lstName = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200,height: 110)
                    .padding(.bottom, 50)
                
                Text("Sign Up")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue .opacity(0.9))
                    .padding(.bottom, 50)
                
                TextField("First Name", text: $fstName)
                    .cornerRadius(5)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 56)
                
                TextField("Last Name", text: $lstName)
                    .cornerRadius(5)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 56)
                
                TextField("Email", text: $email)
                    .cornerRadius(5)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 56)
                
                SecureField("Password", text: $password)
                    .cornerRadius(5)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 56)
                    .padding(.bottom, 50)
                
                if fstName.isEmpty, lstName.isEmpty, email.isEmpty, password.isEmpty {
                    
                } else {
                    Button("SignUp", role: .cancel) {
                        DBHelper.addData(email: email, password: password)
                        print("true")
                    }
                    .padding(.bottom, 150)
                    .foregroundColor(.blue . opacity(0.9))
                }
            }
        }
    }
}

#Preview {
    RegistrationPage()
}

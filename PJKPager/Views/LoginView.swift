//
//  LoginView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 11/8/22.
//

import SwiftUI

enum LoginField {
    case username
    case password
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @FocusState private var loginFieldFocus: LoginField?
    @FocusState private var fieldFocus: Bool
    
    var body: some View {
        VStack {
            
            Image(systemName: "phone")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding([.bottom], 40)
            
            Text("Welcome to PJK Pager")
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .username)
                .onSubmit {
                    loginFieldFocus = .password
                }
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .password)
            
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                loginFieldFocus = .username
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

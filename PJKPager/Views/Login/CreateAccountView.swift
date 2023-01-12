//
//  CreateAccountView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/11/23.
//

import Foundation
import SwiftUI

enum CreateAccountField {
    case name
    case username
    case phone
    case email
    case password
}

struct CreateAccountView: View {
    @ObservedObject var vm = LoginViewModel()
    @EnvironmentObject var router: Router<Path>
    @State var showAlert = false
    @State private var hasAccount = [true]
    @FocusState private var loginFieldFocus: CreateAccountField?
    @FocusState private var fieldFocus: Bool
    
    var body: some View {
        VStack {
            
            Text("Create a PJK Pager account!")
            
            TextField("Name", text: $vm.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .name)
                .onSubmit {
                    loginFieldFocus = .username
                }
            
            TextField("Username", text: $vm.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .username)
                .onSubmit {
                    loginFieldFocus = .phone
                }
            
            TextField("Phone: xxx-xxx-xxxx", text: $vm.phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .phone)
                .onSubmit {
                    loginFieldFocus = .email
                }
            
            TextField("Email", text: $vm.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .email)
                .onSubmit {
                    loginFieldFocus = .password
                }
            
            SecureField("Password", text: $vm.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal], 80)
                .focused($loginFieldFocus, equals: .password)
            
            Button("Create Account") {
                vm.createUser(router: router)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showAlert = !LoginManager.isAuthenticated()
                }
            }
            .padding()
            .background(Color.white)
            
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

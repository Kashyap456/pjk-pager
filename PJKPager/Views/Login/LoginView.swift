//
//  LoginView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 11/8/22.
//

import SwiftUI

enum LoginField {
    case email
    case password
}

struct LoginView: View {
    @ObservedObject var vm = LoginViewModel()
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject var user: User
    @State var showAlert = false
    @FocusState private var loginFieldFocus: LoginField?
    @FocusState private var fieldFocus: Bool
    
    var body: some View {
        VStack {
            
            Image(systemName: "phone")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding([.bottom], 40)
            
            Text("Welcome to PJK Pager")
            
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
            
            Button("Login") {
                vm.loginUser(router: router, user: user)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showAlert = !LoginManager.isAuthenticated()
                }
            }
            .padding()
            .background(Color.white)
            
            Button("Don't have an account?") {
                router.push(.CreateAccount)
            }
            
        }
        .alert(isPresented: $showAlert, content: {Alert(title: Text(vm.errorMessage))})
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                loginFieldFocus = .email
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

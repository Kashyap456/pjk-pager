//
//  LoginViewModel.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import SwiftUI
import Combine
import KeychainAccess
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    var errorMessage = ""
    let keychain = Keychain(service: "com.PJK.PJKPager")
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let `self` = self else { return }
            if (error != nil) {
                self.errorMessage = "please try again"
                return
            }
            let userRes = authResult?.user
            userRes?.getIDToken(completion: { (res, err) in
                if (err != nil) {
                    self.errorMessage = "please try again"
                    return
                } else {
                    self.keychain["pjk-pager-authtoken"] = res
                    LoginManager.Authenticated.send(true)
                }
            })
        }
    }
}

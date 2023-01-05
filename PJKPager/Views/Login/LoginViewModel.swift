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

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    var error = ""
    let keychain = Keychain(service: "com.PJK.PJKPager")
    
    func loginUser() -> Bool  {
        if username == "kashyap456", password == "dinkdoink" {
            let token = UUID().uuidString
            keychain["pjk-pager-authtoken"] = token
            LoginManager.Authenticated.send(true)
            return true
        } else {
            error = "please try again"
            return false
        }
    }
}

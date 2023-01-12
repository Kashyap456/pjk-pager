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
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var username = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
    
    var errorMessage = ""
    let keychain = Keychain(service: "com.PJK.PJKPager")
    let db = Firestore.firestore()
    
    func loadUser(user: User) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let doc = db.collection("users").document(uid)
        doc.getDocument { (document, error) in
            guard error == nil else { return }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    user.username = data["username"] as? String ?? ""
                }
            }
        }
    }
    
    func loginUser(router: Router<Path>, user: User) {
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
                    user.email = self.email
                    user.password = self.password
                    self.loadUser(user: user)
                    router.push(.Base)
                    LoginManager.Authenticated.send(true)
                }
            })
        }
    }
    
    func createUser(router: Router<Path>) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
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
                    self.db.collection("users").document(res!).setData([
                        "name": self.name,
                        "phone": self.phone,
                        "email": self.email,
                        "username": self.username,
                        "createdAt": FieldValue.serverTimestamp()
                    ]) { dberr in
                        if let dberr = dberr {
                            self.errorMessage = "DB write error"
                        } else {
                            self.keychain["pjk-pager-authtoken"] = res
                            router.push(.Base)
                            LoginManager.Authenticated.send(true)
                        }
                    }
                }
            })
        }
    }
}

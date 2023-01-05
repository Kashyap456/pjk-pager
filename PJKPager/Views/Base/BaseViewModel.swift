//
//  BaseViewModel.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import KeychainAccess

class BaseViewModel : ObservableObject {
    let keychain = Keychain(service: "com.PJK.PJKPager")
    
    func logoutUser() {
        LoginManager.Authenticated.send(false)
        keychain["pjk-pager-authtoken"] = nil
    }
}

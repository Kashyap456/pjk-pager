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
    
    func logoutUser(router: Router<Path>) {
        LoginManager.Authenticated.send(false)
        router.pop()
        keychain["pjk-pager-authtoken"] = nil
    }
}

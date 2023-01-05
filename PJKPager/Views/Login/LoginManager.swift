//
//  LoginManager.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import Combine
import KeychainAccess

struct LoginManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func isAuthenticated() -> Bool {
        let keychain = Keychain(service: "com.PJK.PJKPager")
        return keychain["pjk-pager-authtoken"] != nil;
    }
}

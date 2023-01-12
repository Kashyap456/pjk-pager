//
//  UserModel.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 12/29/22.
//

import Foundation

class User : ObservableObject {
    @Published var name = ""
    @Published var username = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
}

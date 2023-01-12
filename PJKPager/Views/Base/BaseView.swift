//
//  BaseView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import SwiftUI

struct BaseView : View {
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject var user: User
    
    var bm = BaseViewModel()
    
    var body : some View {
        VStack {
            Text("Hello")
            Text(user.username)
            
            Button("Log Out") {
                bm.logoutUser(router: router)
            }
        }
    }
}

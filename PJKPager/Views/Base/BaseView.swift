//
//  BaseView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import SwiftUI

struct BaseView : View {
    var bm = BaseViewModel()
    var body : some View {
        VStack {
            Button("Log Out") {
                bm.logoutUser()
            }
        }
    }
}

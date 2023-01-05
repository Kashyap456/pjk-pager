//
//  HomeView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import SwiftUI

struct HomeView : View {
    @State var isAuthenticated = LoginManager.isAuthenticated()
    
    var body : some View {
        Group { isAuthenticated ? AnyView(BaseView()) : AnyView(LoginView()) }
        .onReceive(LoginManager.Authenticated, perform: {
            isAuthenticated = $0
        })
    }
}

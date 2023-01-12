//
//  HomeView.swift
//  PJKPager
//
//  Created by Kashyap Chaturvedula on 1/4/23.
//

import Foundation
import SwiftUI

final class Router<T: Hashable>: ObservableObject {
    @Published var paths: [T] = []
    
    func push(_ path: T) {
        paths.append(path)
    }
    
    func pop() {
            paths.removeLast(1)
    }
}

enum Path {
    case Login
    case CreateAccount
    case Base
}

struct HomeView : View {
    @State var isAuthenticated = LoginManager.isAuthenticated()
    @ObservedObject var router = Router<Path>()
    @ObservedObject var user = User()
    
    var body : some View {
        NavigationStack(path: $router.paths) {
            LoginView()
                .navigationDestination(for: Path.self) { path in
                    switch path {
                        case .Login : LoginView()
                        case .CreateAccount : CreateAccountView()
                        case .Base : BaseView().navigationBarBackButtonHidden()
                    }
                }
        }
        .environmentObject(router)
        .environmentObject(user)
        .onReceive(LoginManager.Authenticated, perform: {
            isAuthenticated = $0
        })
    }
}

//
//  TestSwiftUIApp.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI


class AppState: ObservableObject {
    @Published var user: User = User()
    @Published var globalCount: Int = 0
}

struct User {
    var name: String
    
    init(name: String = "Kevin") {
        self.name = name
    }
}

@main
struct TestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(appState: AppState())
        }
    }
}

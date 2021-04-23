//
//  TestSwiftUIApp.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI
import Combine


struct AppState {
    var user: User = User()
    var globalCounter: Counter = Counter()
}

class Counter: ObservableObject {
    @Published var count: Int = 0
}

class User: ObservableObject {
    @Published var name: String
    
    init(name: String = "Kevin") {
        self.name = name
    }
}


protocol CounterViewFactory {
    func makeCounterView() -> AnyView
}

protocol SettingsViewFactory {
    func makeSettingsView() -> AnyView
}

protocol ContentViewFactory {
    func makeContentView() -> AnyView
}

protocol DependencyProvider: CounterViewFactory, SettingsViewFactory, ContentViewFactory {
}

struct DependencyContainer: DependencyProvider {
    var appState = AppState()
}

extension DependencyContainer: CounterViewFactory {
    func makeCounterView() -> AnyView {
        return AnyView(CounterView(viewModel: CounterViewModel(counter: appState.globalCounter)))
    }
}

extension DependencyContainer: SettingsViewFactory {
    func makeSettingsView() -> AnyView {
        return AnyView(SettingsView(viewModel: SettingsViewModel(counterViewFactory: self)))
    }
    
}

extension DependencyContainer: ContentViewFactory {
    func makeContentView() -> AnyView {
        return AnyView(ContentView(viewModel: ContentViewModel(user: appState.user,
                                                               settingsViewFactory: self,
                                                               counterViewFactory: self)))
    }
        
}

let dependencyContainer = DependencyContainer()

@main
struct TestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            dependencyContainer.makeContentView()
        }
    }
}

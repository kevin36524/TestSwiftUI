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
    @Published private(set) var count: Int = 0
    
    func increment() {
        count += 1
    }
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

protocol DependencyProvider: ContentViewFactory {
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

struct FakeContainer: DependencyProvider {
    func makeContentView() -> AnyView {
        return AnyView(Text("Hello World"))
    }
}

struct CounterTestContainer: DependencyProvider {
    let dep = DependencyContainer()
    
    func makeContentView() -> AnyView {
        return dep.makeCounterView()
    }
}

class DepContainerFactory  {
    static let shared = DepContainerFactory()
    
    var container:DependencyProvider = DependencyContainer()
    
    init() {
        if (ProcessInfo().arguments.contains("FAKE-TEST")) {
            container = FakeContainer()
        } else if (ProcessInfo().arguments.contains("COUNTER-TEST")) {
            container = CounterTestContainer()
        }
    }
}


@main
struct TestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            DepContainerFactory.shared.container.makeContentView()
        }
    }
}

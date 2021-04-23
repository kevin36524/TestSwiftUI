//
//  TestSwiftUIApp.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI
import Combine


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


protocol DependencyProvider: CounterViewFactory {
    var appState: AppState {get set}
    
    func makeCounterViewModel() -> CounterViewModel
}

var cancelBag = Set<AnyCancellable>()

struct DependencyContainer: DependencyProvider {
    
    @ObservedObject var appState = AppState()
    
    func makeCounterViewModel() -> CounterViewModel {
        return CounterViewModel(count: $appState.globalCount, countPublisher: appState.$globalCount.eraseToAnyPublisher())
    }
    
}

extension DependencyContainer: CounterViewFactory {
    func makeCounterView() -> AnyView {
        return AnyView(CounterView(viewModel: makeCounterViewModel()))
    }
}

let dependencyContainer = DependencyContainer()

protocol CounterViewFactory {
    func makeCounterView() -> AnyView
}

@main
struct TestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

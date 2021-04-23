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


protocol DependencyProvider {
    var appState: AppState {get set}
    
    func makeCounterViewModel() -> CounterViewModel
    func makeCounterView() -> CounterView
}

var cancelBag = Set<AnyCancellable>()

struct DependencyContainer: DependencyProvider {
    
    @ObservedObject var appState = AppState()
    
    func makeCounterViewModel() -> CounterViewModel {
        return CounterViewModel(count: $appState.globalCount, countPublisher: appState.$globalCount.eraseToAnyPublisher())
    }
    
    func makeCounterView() -> CounterView {
//        return CounterView(count: appState.$globalCount)
        return CounterView(viewModel: makeCounterViewModel())
    }
    
}

extension DependencyContainer: CounterViewFactory {

}

let dependencyContainer = DependencyContainer()

protocol CounterViewFactory {
    func makeCounterView() -> CounterView
}


@main
struct TestSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI
import Combine


struct ContentViewModel {
    let user: User
    let settingsViewFactory: SettingsViewFactory
    let counterViewFactory: CounterViewFactory
}

struct ContentView: View {
    @ObservedObject var user: User
    var viewModel: ContentViewModel
    @State var isSettingsViewShown: Bool = false
        
    var body: some View {
            NavigationView {
                
                VStack {
                    Text("Hello, \(user.name)!")
                        .padding()
                    Button(action: navigateToSettings) {
                        Text("Settings")
                    }
                    
                    let settingsView = viewModel.settingsViewFactory.makeSettingsView()
                    
                    NavigationLink(destination: settingsView, isActive: $isSettingsViewShown) {
                    }
                    
                    viewModel.counterViewFactory.makeCounterView()
                }
            }
    }
    
    func navigateToSettings() {
        print("KEVINDEBUG I will navigate to settings")
        isSettingsViewShown = true
    }
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        self.user = viewModel.user
    }
}

struct CounterViewModel {
    var counter: Counter
}

struct CounterView: View {
    @ObservedObject var counter: Counter
    
    var body: some View {
        VStack {
            Text("Global Count \(counter.count)").padding()
            Button(action: {
                counter.increment()
            }, label: {
                Text("Global Increment")
            })
        }
    }
    
    init(viewModel: CounterViewModel) {
        self.counter = viewModel.counter
    }
}

struct SettingsViewModel {
    var localCount = 0
    var name: String = "Foo"
    let counterViewFactory: CounterViewFactory
}

struct SettingsView: View {
    @State var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            Text("Settings for \(viewModel.name)").padding()
            Text("Local Count \(viewModel.localCount)").padding()
            Button(action: {
                viewModel.localCount += 1
                viewModel.name = "Kevin mutated"
            }, label: {
                Text("Inc Local")
            })
            
            viewModel.counterViewFactory.makeCounterView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    struct DummyFactory:SettingsViewFactory, CounterViewFactory {
        func makeCounterView() -> AnyView {
            return AnyView(Text("Counter"))
        }
        
        func makeSettingsView() -> AnyView {
            return AnyView(Text("Settings"))
        }
        
    }
    static var previews: some View {
        let dummyFactory = DummyFactory()
        ContentView(viewModel: ContentViewModel(user: User(), settingsViewFactory: dummyFactory, counterViewFactory: dummyFactory))
    }
}
    

//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var isSettingsViewShown: Bool = false
    let name = "Kevin"
    
    var body: some View {
            NavigationView {
                
                VStack {
                    Text("Hello, \(name)!")
                        .padding()
                    Button(action: navigateToSettings) {
                        Text("Settings")
                    }
                    
                    let settingsViewModel = SettingsViewModel(name: name, counterViewFactory: dependencyContainer)
                    let settingsView = SettingsView(viewModel: settingsViewModel)
                    
                    NavigationLink(destination: settingsView, isActive: $isSettingsViewShown) {
                    }
//
//                    let counterViewModel = CounterViewModel(count: $appState.globalCount)
//                    CounterView(viewModel: counterViewModel)
                    
                    dependencyContainer.makeCounterView()
                }
            }
    }
    
    func navigateToSettings() {
        print("KEVINDEBUG I will navigate to settings")
        isSettingsViewShown = true
    }
}

struct CounterViewModel {
    @Binding var count: Int
    var countPublisher: AnyPublisher<Int, Never>
}

struct CounterView: View {
    @State var viewModel: CounterViewModel
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            Text("Global Count \(count)").padding()
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("Global Increment")
            })
        }.onReceive(viewModel.countPublisher, perform: { _ in
            print("KEVINDEBUG the value is being updated\(viewModel.count)")
            count = viewModel.count
        })
    }
}

struct SettingsViewModel {
    var localCount = 0
    var name: String
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
    static var previews: some View {
        ContentView()
            
    }
}
    

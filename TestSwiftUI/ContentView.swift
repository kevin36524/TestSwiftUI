//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI

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
    var count: Binding<Int>
}

struct CounterView: View {
    var count: Published<Int>.Publisher
    @State var displayCount = 0
    
    var body: some View {
        VStack {
            Text("Global Count \(displayCount)").padding()
            Button(action: {
                dependencyContainer.appState.globalCount += 1
            }, label: {
                Text("Global Increment")
            })
        }.onReceive(count, perform: { newVal in
            displayCount = newVal
        })
    }
    
//    init(viewModel: CounterViewModel) {
//        self._count = viewModel.count
//    }
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
    

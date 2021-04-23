//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Kevin Patel on 4/22/21.
//

import SwiftUI

struct ContentView: View {
    @State var isSettingsViewShown: Bool = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
            NavigationView {
                
                VStack {
                    Text("Hello, \(appState.user.name)!")
                        .padding()
                    Button(action: navigateToSettings) {
                        Text("Settings")
                    }
                    
                    let settingsViewModel = SettingsViewModel(name: appState.user.name)
                    let settingsView = SettingsView(viewModel: settingsViewModel)
                    
                    NavigationLink(destination: settingsView, isActive: $isSettingsViewShown) {
                    }
                    
                    let counterViewModel = CounterViewModel(count: $appState.globalCount)
                    CounterView(viewModel: counterViewModel)
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
}

struct CounterView: View {
    
    var viewModel: CounterViewModel
    
    var body: some View {
        VStack {
            Text("Global Count \(viewModel.count)").padding()
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("Global Increment")
            })
        }
    }
}

struct SettingsViewModel {
    var localCount = 0
    var name: String
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
            
            // TODO need to get the global count reference
            let counterViewModel = CounterViewModel(count: $viewModel.localCount)
            CounterView(viewModel: counterViewModel)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    

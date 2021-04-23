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
                    
                    CounterView()
                }
            }
    }
    
    func navigateToSettings() {
        print("KEVINDEBUG I will navigate to settings")
        isSettingsViewShown = true
    }
}

struct CounterView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Global Count \(appState.globalCount)").padding()
            Button(action: {
                appState.globalCount += 1
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
            CounterView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    

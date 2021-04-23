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
                    
                    NavigationLink(destination: SettingsView(globalCount: $appState.globalCount), isActive: $isSettingsViewShown) {
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

struct SettingsView: View {
    @State var localCount = 0
    @Binding var globalCount: Int
    
    var body: some View {
        VStack {
            Text("Settings").padding()
            Text("Local Count \(localCount)").padding()
            Button(action: {
                localCount += 1
                globalCount += 1
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
    

//
//  TodoApp.swift
//  Todo
//
//  Created by 登秝吳 on 01/07/2020.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct TodoApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            print("Amplify initialized")
        } catch {
            print("could not initialize Amplify - \(error)")
        }
    }

}

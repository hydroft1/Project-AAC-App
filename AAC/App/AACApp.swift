//
//  AACApp.swift
//  AAC
//
//  Created by Alexandre Marquet on 26/07/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AACApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegete
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

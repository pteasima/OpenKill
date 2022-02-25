//
//  OpenKillApp.swift
//  Shared
//
//  Created by Petr Šíma on 24.02.2022.
//

import Firebase
import Foundation
import SwiftUI

@main
struct OpenKillApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

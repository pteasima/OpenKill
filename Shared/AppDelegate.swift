//
//  AppDelegate.swift
//  OpenKill
//
//  Created by Serhij Nistor on 24.02.2022.
//
import Firebase
import Foundation
import SwiftUI

// @UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}

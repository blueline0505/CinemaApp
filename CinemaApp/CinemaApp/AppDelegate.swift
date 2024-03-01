//
//  AppDelegate.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
        return true
    }



}


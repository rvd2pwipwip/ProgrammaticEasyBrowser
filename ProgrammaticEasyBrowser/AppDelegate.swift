//
//  AppDelegate.swift
//  ProgrammaticEasyBrowser
//
//  Created by Herve Desrosiers on 2020-02-13.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController? // declare the navigationController that will be the entry point of the app

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainVC = ViewController()
        navigationController = UINavigationController(rootViewController: mainVC) // the starting point of the navigation stack is mainVC, an instance of ViewController
        window?.rootViewController = navigationController // the app's entry point is the navigationController (Is Initial View Controller)
        window?.makeKeyAndVisible()
        
        return true
    }
}

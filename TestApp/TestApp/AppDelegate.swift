//
//  AppDelegate.swift
//  TestApp
//
//  Created by Nitin A on 02/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigation = UINavigationController(rootViewController: FeedController())
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
}


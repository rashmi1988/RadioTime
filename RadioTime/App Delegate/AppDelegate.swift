//
//  AppDelegate.swift
//  RadioTime
//
//  Created by Rashmi on 10/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // customisation of nav and tool bars which will affect whole application
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 43.0/255.0, green: 87.0/255.0, blue: 126.0/255.0, alpha: 1.0)  // solid color
        UIBarButtonItem.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = UIColor(red: 179.0/255.0, green: 218.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        // Start the timer to show ad before playing music
        // To show ad after 10 minute interval
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "AdTimer")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//
//  AppDelegate.swift
//  RealmPOC
//
//  Created by David Tan on 1/12/21.
//  Copyright © 2021 David Tan. All rights reserved.
//

import RealmSwift
import SwiftUI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let app = MongoDBRealm().app()
        let credentials = MongoDBRealm().getCredentials()

        app.login(credentials: credentials) { (result) in
        switch result {
        case .failure(let error):
            print("Login failed: \(error.localizedDescription)")
        case .success(let user):
            print("Successfully logged in as user \(user)")
            // Now logged in, do something with user
            // Remember to dispatch to main if you are doing anything on the UI thread
        }
        }
        
        guard let configuration = MongoDBRealm().configure(partitionValue: "Raleigh") else {
            return false
        }
        
        Realm.asyncOpen(configuration: configuration) { result in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // handle error
        case .success(let realm):
            print("Successfully opened realm: \(realm)")
            // Use realm
        }
        }
        
//        let realm = MongoDBRealm().getRealm(partitionValue: "MSHA1")
        
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


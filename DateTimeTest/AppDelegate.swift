//
//  AppDelegate.swift
//  DateTimeTest
//
//  Created by lcx on 2021/11/6.
//

import UIKit
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            let dataModel = AmplifyModels()
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: dataModel))
            try Amplify.configure()
        } catch {
            print("failed to configure amplify")
        }
        let dateTime = Temporal.DateTime.now()
        let item = DateTimeTest(dateTime: dateTime)
        Amplify.DataStore.save(item) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
        Amplify.DataStore.query(DateTimeTest.self) { result in
            switch(result) {
            case .success(let items):
                for item in items {
                    guard let dateTime = item.dateTime else { continue }
                    let formatter = DateFormatter()
                    formatter.timeZone = .current
                    formatter.locale = .current
                    // https://nsdateformatter.com/
                    formatter.dateFormat = "MM-dd-yyyy HH:mm:ss a"
                    print(formatter.string(from: dateTime.foundationDate))
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
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


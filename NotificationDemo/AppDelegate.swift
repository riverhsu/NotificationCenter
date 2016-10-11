//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by Peter Pan on 8/15/16.
//  Copyright © 2016 Peter Pan. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //UNUserNotificationCenter 物件是通知中心
        //UNUserNotificationCenter.current() 取得 UNUserNotificationCenter 物件
        //requestAuthorization 方法, 是微求使用者同恴 App 發送通知
        //   options: 設定我們希望使用者同意的通知樣式, Struct 的型別. 名稱: UNAuthorizationOptions
        //   completionHandler: 在使用者同恴或拒絕我們執行時，傳入closure, 它的參數是
        //      granted: Bool 型別. 告訴我們使用者是否同意
        //      error: Error 型別. 若有錯誤, 可從 error 了解錯誤原因        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {granted, error in
            if granted {
                print ("使用者同意了，每天都能收到米花兒的幸福訊息")
            } else {
                print("使用者不同意")
            }
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


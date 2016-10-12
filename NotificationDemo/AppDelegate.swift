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
        
        // 將 AppDelegate 物件設為 UNUserNotificationCenter 的代理人。
        // 當 App 在前景收到執行通知時，UNUserNotificationCenter 物件將請代理人執行此 function
        // 只要在 function 裹呼叫 completionHandler, 即可顯示通知
        UNUserNotificationCenter.current().delegate = self
        
        // 加入客製化的按鈕，設定自訂的通知類別
        // 1. 生成對應到通知按鈕的 UNNotification 物件
        //      共生成 likeAction & dislikeAction 即可在通知上顯示兩個按鈕
        //      UNNotificationAction 的 init 宣告如下
        //      public convenience init(identifier: String, title: String, options: UNNotificationOptions=[])
        //          #identifier: 按鈕的id. 可以判斷使用者點選的按鈕
        //          ＃title: 按鈕顯示的文字
        //          ＃options: 設定按鈕點選後的動作。其型別是 UNNotificationActionOptions
        //              public struct UNNotificationActionOptions: OptionSet{
        //                  public init(rawValue: UInt)
        //                  
                          //Whether this action should require unlocking before being performed.
        //                  public static var authenticationRequired: UNNotificationActionOptions { get }
                            // Whether this action should be indicated as destructive.
        //                  public static var destructive: UNNotificationActionOptions { get }
        //
                            // Whether this action should cause the application to launch in the foreground.
        //                  public static var foreground: UNNotificationActionOptions { get }
        //                  }
        
        //在 likeAction,我們傳入 [.foreground],表示點選後將打開 APP，而dislikeAction傳入[] 則會關閉推播，不打開APP
        let likeAction = UNNotificationAction(identifier: "like", title: "好感動", options: [.foreground])
        let dislikeAction = UNNotificationAction(identifier: "dislike", title: "沒感覺", options: [])
        
        //   2. 跟通知中心註冊包含客製按鈕的特別通知
        //      生成 UNNotificationCategory 物件，將它設為 UNUserNotificationCenter 物件的 NotificationCategories. 它定義了 App 支援的特別通知
        //      當 App 收到通知時，將比對通知內容的 categoryIdentifier 找尋對應的特別通知，而特別通知顯示的按鈕即由當被傳入的 actions 決定
        //      intentIdentifiers,options 屬於進階的設定，先放[]
        let category = UNNotificationCategory(identifier: "luckyMessage", actions: [likeAction, dislikeAction], intentIdentifiers: [], options: [])
        
        //  一個 App 可以支援多種不同按鈕的通知，只要呼叫 setNotificationCategories 傳入包含多個 UNNotificationCategory 物件的 Array. 每個指定不同的 id & actions
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
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

// 前景通知
// 在前景顯示推播，在 iOS 10 的作法，只要依照下列方式執行
// 擴充 AppDelegate 功能，讓它遵從 UNUserNotificationCenterDelegate 協定
// 並定義 userNotificationCenter(_:willPresent:withCompletionHandler)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // completionHandler 的型別為 UNNotificationPresentationOptions
        // public struct UNNotificationPresentationOptions: OptionSet {
        // 
        //      public init(rawValue: UInt)
        //  
        //      public static var badge: UNNotificationPresentationOption {get}
        //      public static var badge: UNNotificationPresentationOption {get}
        //      public static var badge: UNNotificationPresentationOption {get}
        // }
        
        //表示我們想同時顯示 "通知，發出聲音及更新 App Icon上的數字"
        completionHandler([.badge, .sound, .alert])
    }
    
    
    //客製化使用者點擊通知後做的事情
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler:  @escaping () -> Void) {
        
        //若要解析通知的內容，必須透過參數 reponse, 從 reponse.notification.request.content 找出我們要的內容
        //UNNofiticationContent 物件，客製化的資訊包含在 userInfo 裹。
        let content = response.notification.request.content
        print("title \(content.title)")
        print("userInfo \(content.userInfo)")
        
        //=================================================================================
        //判斷使用者點選 "通知" 的那一個按鈕
        //如果是客製化按鈕, .actionIdentifier 將為當初 UNNotification 物件的 identifier
        print("actionIdentifier \(response.actionIdentifier)")
        
        completionHandler()

    }
}


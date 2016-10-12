//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Peter Pan on 8/15/16.
//  Copyright © 2016 Peter Pan. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UIPickerViewDelegate {
    
    @IBAction func createNotification(_ sender: AnyObject) {
        
        //create Content object which is about the notification text
        let content = UNMutableNotificationContent()
        
        //The format of content
        content.title = "體驗過了，才是你旳"
        content.subtitle = "米花兒"
        content.body = "不要追問為什麼，就笨拙地走入未知。感受眼前的怦然與顱抖，聽聽左邊的碎裂和跳動。不管好的壞的，只有體驗過了，才是你的。"
        
        //設定 App Icon 顯示的數字
        content.badge = 1
        //設定通知發出的聲音。型別:UNNotificationSound。若無指定則為無聲。
        //若要指定聲音，只要將音檔放到專案裹，指定檔名。
        // content.sound = UNNotificationSound(named: "小幸運"). 副檔名須為 aiff, wav or caf, 不得大於30秒
        content.sound = UNNotificationSound.default()
        
        //在通知加入圖片,音樂,影片 -》UNNotificationAttachment
        
        //1. 先取得圖片的 url; 所以圖片一定要加到 project navigator 的清單裹; 
        //   不能放在 Assets.xcassets (因為無法取得圖片裹的 url
        let imageURL = Bundle.main.url(forResource: "pic", withExtension: "jpg")
        //2. 生成 UNNotificationAttachment 物件
        //   使用 ""，系統會自動生成一組 id
        //   options: 可以做一些進階設定
        let attachment = try! UNNotificationAttachment(identifier: "", url: imageURL!, options:nil)
        content.attachments = [attachment]
        
        
        //設定通知觸發條件，可以設定幾秒鐘之後觸發通知
        //  timeInterval: 設定秒數
        //  repeats: 設定是否重複
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        // 總共有4種方法可以觸發通知
        // 1. UNTimeIntervalNotificationTrigger: 幾秒鐘後觸發
        // 2. UNCalendarNotificationTrigger: 指定某個時刻觸發
        // 3. UNLocationNotificationTrigger: 使用者靠近某個位置時觸發。
        // 4. UNPushNotificationTrigger: 從千里之外的後台，傳送到使用者手機的通知
        
        
        //建立 request 物件。有了它，才能和通知中心請求發送通知
        //  public convenience init(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger?)
        //  建立 request 傳入 content & trigger, 通知中心才知道通知的內容和觸發的條件
        //  參數 identifier 設定 request 的 id; 如果要取消請求的通知，則可透過此 id 取消 request
        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        
        //取消 request 的方法
        /*
         Pending: 是使用者還沒收到的未來通知
         Delivered: 則是已經收到，但還顯示在通知頁面，還未點開觀看的通知
        open func removePendingNotificationRequests(withIdentifiers identifiers: [String])
        open func removePendingNotificationRequests()
        open func removeDeliveredNotifications(withIdentifiers identifiers: [String])
        open func removeAllDeliveredNotifications()
        */
        
        //系統將呼叫 completionHandler 參數，經由它的 Error 型別參數告訴我們通知請求是否被接受
        // 我們也可以在 withCompletionHandler 傳入 closure, 判斷請求是否成功; 因為我們不管結果, 所以使用 nil
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


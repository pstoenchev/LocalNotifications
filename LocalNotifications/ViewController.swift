//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Mac on 6.10.20.
//  Copyright © 2020 peter. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    var dueDate = Date()
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    showDataLabel()
        // Do any additional setup after loading the view.
    }

    @IBAction func notificationBtn(_ sender: UIButton) {

        // MARK: - Button under images.
        let answerOne = UNNotificationAction(identifier: "a1", title: "picture 1", options: [.foreground])
        let answerTwo = UNNotificationAction(identifier: "a2", title: "picture 2", options: [.foreground])
        let quizz = UNNotificationCategory(identifier: "quizz", actions: [answerOne, answerTwo], intentIdentifiers: [], options: [])
        
        // MARK: - Permissions for notifications.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
              granted, error in
                 if granted {
                     print("we have permission")
                    self.setNotificationCategories()
                 } else {
                     print("no perm")
                 }
             }
        
        // MARK: - Load big Picture
        let url = Bundle.main.url(forResource: "images/pi", withExtension: "png")
        let content = UNMutableNotificationContent()
        if let attachment = try? UNNotificationAttachment(identifier: "ok", url: url!, options: nil) {
            content.attachments = [attachment]
        }

       content.categoryIdentifier = "quizz"
       content.title = "Hello"
       content.body = "Local notification"
        content.sound = UNNotificationSound.defaultCritical
        content.badge = 6
        
       let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
       
       let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: triger)
     
   
        center.add(request)
        center.setNotificationCategories([quizz])
    }
    private func setNotificationCategories() {
      
      let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: [])
      let replyAction = UNNotificationAction(identifier: "reply", title: "Reply", options: [])
      let archiveAction = UNNotificationAction(identifier: "archive", title: "Archive", options: [])
      let  ccommentAction = UNTextInputNotificationAction(identifier: "comment", title: "Comment", options: [])
      
      
      let localCat =  UNNotificationCategory(identifier: "category", actions: [likeAction], intentIdentifiers: [], options: [])
      
      let customCat =  UNNotificationCategory(identifier: "recipe", actions: [likeAction,ccommentAction], intentIdentifiers: [], options: [])
      
      let emailCat =  UNNotificationCategory(identifier: "email", actions: [replyAction, archiveAction], intentIdentifiers: [], options: [])
      
      UNUserNotificationCenter.current().setNotificationCategories([localCat, customCat, emailCat])

    }
    
    func showDataLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: Date())
    }
    
    
    @IBAction func dateChanged(_ sender: Any) {
        dueDate = datePicker.date
        datePicker.setDate(dueDate, animated: true)
        updateDueDateLabel()
    }
    
    private func updateDueDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: dueDate)
    }
}

//extension ViewController: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        switch response.actionIdentifier {
//        case "a1":
//            print("picture 1")
//        case "a2":
//            print("ok")
//        default:
//            print("no good")
//        }
//    }
//}

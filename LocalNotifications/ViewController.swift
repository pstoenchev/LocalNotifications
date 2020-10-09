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
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDataLabel()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func notificationBtn(_ sender: UIButton) {
        
        // MARK: - Button under images.
        let answerOne = UNNotificationAction(identifier: "a1", title: "picture 1", options: [.foreground])
        let answerTwo = UNNotificationAction(identifier: "a2", title: "picture 2", options: [.foreground])
        let quizz = UNNotificationCategory(identifier: "quizz", actions: [answerOne, answerTwo], intentIdentifiers: [], options: [])
        
        // MARK: - Permissions for notifications.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { print("no perm"); return }
            
            print("we have permission")
            let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "MyNotification", content: .standard(categoryIdentifier: "quizz", title: "Hello", body: "Body", sound: .default), trigger: triger)
            
            center.setNotificationCategories([quizz])
            center.add(request)
        }
    }
    
    private func showDataLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: Date())
    }
    
    private func updateDueDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: dueDate)
    }
    
    @IBAction private func dateChanged(_ sender: Any) {
        dueDate = datePicker.date
        datePicker.setDate(dueDate, animated: true)
        updateDueDateLabel()
    }
}


extension UNNotificationContent {
    static func standard(categoryIdentifier: String,
                         title: String,
                         body: String,
                         sound: UNNotificationSound?,
                         attachments: [UNNotificationAttachment] = .standard) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = categoryIdentifier
        content.title = title
        content.body = body
        content.sound = sound
        content.attachments = attachments
        
        return content
    }
}

extension Array where Element == UNNotificationAttachment {
    
    static var standard: [UNNotificationAttachment] {
        guard let url = Bundle.main.url(forResource: "images/pi", withExtension: "png") else { return [] }
        guard let attachment = try? UNNotificationAttachment(identifier: "ok", url: url, options: nil) else { return [] }
        return [attachment]
    }
}

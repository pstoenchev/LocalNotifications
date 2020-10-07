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

     let center = UNUserNotificationCenter.current()
             center.requestAuthorization(options: [.alert, .sound]) {
              granted, error in
                 if granted {
                     print("we have permission")
                 } else {
                     print("no perm")
                 }
             }
       let content = UNMutableNotificationContent()


       content.title = "Hello"
       content.body = "Local notification"
       content.sound = UNNotificationSound.default
       
       let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
       
       let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: triger)
   
        center.add(request)
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



//
//  NotificationsManager.swift
//  LocalNotifications
//
//  Created by Stoyan Stoyanov on 09/10/2020.
//  Copyright © 2020 peter. All rights reserved.
//

import Foundation
import UserNotifications


// MARK: - Class Definition

final class NotificationsManager: NSObject {
    
    static let shared = NotificationsManager()
    
    private override init() { }
}

// MARK: - UNUserNotificationCenter Delegate

extension NotificationsManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "a1": print("a1")
        case "a2": print("a2")
            
        default:
            print("default case")
        }
    }
}

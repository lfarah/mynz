//
//  NotificationManager.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/22/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class NotificationManager: AnyObject {

	// MARK: - Variables
	static let sharedInstance = NotificationManager()

	// MARK: - Public Methods

	func alertExploded() {

		// Local
		openAlertExploded()
		localAlertExploded()
	}
  
	// MARK: - Local Notifications

	func localAlertExploded() {

		let notification = UILocalNotification()
		notification.alertBody = "You got Exploded!" // text that will be displayed in the notification
		notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
		notification.fireDate = NSDate(timeIntervalSinceNow: 0)
		notification.soundName = UILocalNotificationDefaultSoundName
//		notification.category = "TODO_CATEGORY"
		UIApplication.sharedApplication().scheduleLocalNotification(notification)
	}

// MARK: - Open App Notifications

	func openAlertExploded() {
		let alert = UIAlertController(title: "Booom", message: "You got Exploded!", preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)

		alert.addAction(okAction)
		if UIApplication.sharedApplication().keyWindow?.rootViewController?.presentedViewController == nil {
			UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
		}
	}

// MARK: - Push Notifications
  
  //MARK: - Other App Alerts
  func alertError(error: String) {
    
    let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
    
    alert.addAction(okAction)
    if UIApplication.sharedApplication().keyWindow?.rootViewController?.presentedViewController == nil {
      UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
  }

  func showLocationSettingAlert() {
    let alertController = UIAlertController(
      title:  "Location Access Disabled",
      message: "MYNZ needs to know where you are for the game to work",
      preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
      if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
        UIApplication.sharedApplication().openURL(url)
      }
    }
    alertController.addAction(openAction)
    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
  }

}

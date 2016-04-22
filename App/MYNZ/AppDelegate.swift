//
//  AppDelegate.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/8/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

		// MARK: - Parse stuff
		Parse.enableLocalDatastore()

		// Initialize Parse
		Parse.setApplicationId("ngxAEZ3wKXtA1FOZomujvdF4WBspAZuecPJiw0jY",
			clientKey: "D0JXa5WwrNxw5xCG4NknWnpLgoQ0WHDW7xniFvvd")

		// [Optional] Track statistics around application opens.
		PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

		// Push Notifications
		let userNotificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]

		let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
		application.registerUserNotificationSettings(settings)
		application.registerForRemoteNotifications()

		// If user already logged in
		if PFUser.currentUser() != nil {
			let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
			let homeViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainVC")
			window!.rootViewController = homeViewController

			// Downloading traps from Parse
			TrapManager.sharedInstance.downloadTraps()
		}

		return true
	}

	// Push Notifications
	func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
		// Store the deviceToken in the current Installation and save it to Parse
		let installation = PFInstallation.currentInstallation()
		installation.setDeviceTokenFromData(deviceToken)
		installation.saveInBackground()
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

		// Downloading traps from Parse
		TrapManager.sharedInstance.downloadTraps()
    Location.sharedInstance.requestLocation()
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

		// Downloading traps from Parse
		TrapManager.sharedInstance.downloadTraps()
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
}

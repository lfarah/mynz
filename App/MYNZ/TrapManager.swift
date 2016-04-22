//
//  TrapManager.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/9/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Parse

class TrapManager: AnyObject {

	// MARK: - Variables

	var traps: [Trap] = []
	static let sharedInstance = TrapManager()
	var lastTimeExploded = NSDate(timeIntervalSince1970: 0)
  
	// MARK: - Methods

	// Downloading all traps from Parse to [Trap] array
	func downloadTraps() {

		let query = PFQuery(className: "Mine")
		let loc = Location.sharedInstance.locationManager.location
		query.whereKey("location", nearGeoPoint: PFGeoPoint(location: loc))
		query.findObjectsInBackgroundWithBlock { (arr, error) in

			if error == nil {
				if let objs = arr {
					// Removing all traps before downloading new ones
					self.traps.removeAll()

					for obj in objs {
						if let geo = obj["location"] as? PFGeoPoint, userId = obj["userId"] as? String {

							// Converting PFGeopointo to CLLocation
							let loc = CLLocation(latitude: geo.latitude, longitude: geo.longitude)

							let trap = Trap(location: loc, type: .Mine, userId: userId, objectId: obj.objectId!)
							self.traps.append(trap)
						}
					}
				}
			} else {
				print(error)
			}
		}
	}

	// Checks if user got exploded - distance from bomb less than 10m
	func explodeCheck() {
    
    let interval = lastTimeExploded.timeIntervalSinceNow
		if abs(interval) > 60 {
			let currentLoc = Location.sharedInstance.locationManager.location!
			for trap in traps {
				let distance = currentLoc.distanceFromLocation(trap.location)
				if distance < 10 {
					print("BOOM")
          
          NotificationManager.sharedInstance.alertExploded()
          trap.remove()

          lastTimeExploded = NSDate(timeIntervalSinceNow: 0)
					// After exploded, download all traps again
					downloadTraps()
				}
			}
		}
	}
}

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

	var traps: [Trap] = []
	static let sharedInstance = TrapManager()

	func downloadTraps() {

		let query = PFQuery(className: "Mine")
		let loc = Location.sharedInstance.lastLocation
		query.whereKey("location", nearGeoPoint: PFGeoPoint(location: loc))
		query.findObjectsInBackgroundWithBlock { (arr, error) in

			if error == nil {
				if let objs = arr {
					// Removing all traps before downloading new ones
					self.traps.removeAll()

					for obj in objs {
            if let geo = obj["location"] as? PFGeoPoint, userId = obj["userId"] as? String {
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

	func alert() {
		let alert = UIAlertController(title: "Booom", message: "You got Exploded!", preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)

		alert.addAction(okAction)
		UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
	}

	// Checks if user got exploded - distance from bomb less than 10m
	func explodeCheck() {

		let currentLoc = Location.sharedInstance.locationManager.location!
		for trap in traps {
			let distance = currentLoc.distanceFromLocation(trap.location)
			if distance < 10 {
				print("BOOM")
				alert()
				trap.remove()

				// After exploded, download all traps again
				downloadTraps()
			}
		}
	}
}

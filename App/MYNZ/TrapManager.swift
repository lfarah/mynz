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
				if let objs = arr
				{
					// Removing all traps before downloading new ones
					self.traps.removeAll()

					for obj in objs {
						let geo = obj["location"] as! PFGeoPoint
						let loc = CLLocation(latitude: geo.latitude, longitude: geo.longitude)

						let trap = Trap(location: loc, type: .Mine, userId: "", objectId: obj.objectId!)
						self.traps.append(trap)
					}
				}
			}
			else {
				print(error)
			}
		}
	}

	func explodeCheck() {

			let currentLoc = Location.sharedInstance.locationManager.location!
			for trap in traps
			{
				let distance = currentLoc.distanceFromLocation(trap.location)
				if distance < 10 {
					print("BOOM")
					trap.remove()

          // After exploded, download all traps again
					downloadTraps()
				}
		}
	}
}

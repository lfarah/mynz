//
//  Location.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/9/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class Location: NSObject, CLLocationManagerDelegate {
	var locationManager = CLLocationManager()
	var lastLocation: CLLocation?

	static let sharedInstance = Location()

	func getLocation(handler: ((loc: CLLocation) -> ())) {
		requestLocation()

		lastLocation = locationManager.location!
		handler(loc: locationManager.location!)
	}
	func requestLocation() {

		// For use in foreground
		self.locationManager.requestWhenInUseAuthorization()

		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
	}

	func handleCurrentLocation() {

		let currentLoc = locationManager.location!
		for trap in TrapManager.sharedInstance.traps
		{
			let distance = currentLoc.distanceFromLocation(trap.location)
			print(Int(distance))
			if distance < 10 {
				print("BOOM")
			}
		}
	}
	@objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

		// Updating locationManager.location for getLocation()
		locationManager = manager
		handleCurrentLocation()
	}
}

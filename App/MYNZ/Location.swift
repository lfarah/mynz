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

  func getLocation(handler: ((loc: CLLocation!, error:NSError!) -> ())) {
		requestLocation()
		if let location = locationManager.location {

      lastLocation = location
			handler(loc: location,error: nil)
		}
    else
    {
      let error = NSError(domain: "No location available", code: 1, userInfo: nil)
      handler(loc: nil,error: error)
    }
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

	@objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

		// Updating locationManager.location for getLocation()
    locationManager = manager
    
    if locations.first?.distanceFromLocation(lastLocation!) > 10 {
    NSNotificationCenter.defaultCenter().postNotificationName("updateMap", object: nil)
    }

		TrapManager.sharedInstance.explodeCheck()
	}
}

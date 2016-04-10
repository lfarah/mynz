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
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
	}
  
  func handleCurrentLocation()
  {
    
  }
	@objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

		// Updating locationManager.location for getLocation()
		locationManager = manager
    handleCurrentLocation()
	}
}

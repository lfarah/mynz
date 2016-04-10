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

	// MARK: - Variables
	var locationManager = CLLocationManager()
	var lastLocation: CLLocation?

	static let sharedInstance = Location()

	// MARK: - Methods

	// Returning user's current location
	func getLocation(handler: ((loc: CLLocation!, error: NSError!) -> ())) {
		requestLocation()
		if let location = locationManager.location {

			lastLocation = location
			handler(loc: location, error: nil)
		} else {
			let error = NSError(domain: "No location available", code: 1, userInfo: nil)
			handler(loc: nil, error: error)
		}
	}

	// Requesting user's permission for Location Services access
	func requestLocation() {

		// For use in foreground
		self.locationManager.requestWhenInUseAuthorization()

		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
	}

  func getCity(handler:((city:String) -> ()))
	{
		let geoCoder = CLGeocoder()

		if let loc = lastLocation {
			let location = CLLocation(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
			geoCoder.reverseGeocodeLocation(location) {
        (placemarks, error) -> Void in
        
        let placeArray = placemarks as [CLPlacemark]!
        var placeMark: CLPlacemark!
        placeMark = placeArray?[0]

				if let city = placeMark.addressDictionary?["City"] as? NSString {
					handler(city: city as String)
        } else {
          handler(city: "")
        }
			}
		}
	}

	// MARK: - CLLocationManagerDelegate

	@objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

		// Updating locationManager.location for getLocation()
		locationManager = manager

		// Sending NSNotification for MapDropViewController to update it's MapView
		if locations.first?.distanceFromLocation(lastLocation!) > 10 {
			NSNotificationCenter.defaultCenter().postNotificationName("updateMap", object: nil)
		}

		TrapManager.sharedInstance.explodeCheck()
	}
}

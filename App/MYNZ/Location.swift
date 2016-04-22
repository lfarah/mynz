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

class Location: NSObject {

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
		self.locationManager.requestAlwaysAuthorization()

		if CLLocationManager.locationServicesEnabled() {
			startLocation()
		}
	}

	func startLocation() {

		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()
		locationManager.distanceFilter = 10
	}

	func getCity(handler: ((city: String) -> ())) {
		let geoCoder = CLGeocoder()

		if let loc = lastLocation {
			let location = CLLocation(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
			geoCoder.reverseGeocodeLocation(location) {
				(placemarks, error) -> Void in

				let placeArray = placemarks as [CLPlacemark]!
				var placeMark: CLPlacemark!
				placeMark = placeArray?[0]

				if placeMark != nil {
					if let city = placeMark.addressDictionary!["City"] {
						handler(city: "\(city)")
					} else {
						handler(city: "")
					}
				}
			}
		}
	}
}

// MARK: - CLLocationManagerDelegate
extension Location: CLLocationManagerDelegate {

	@objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

		// Updating locationManager.location for getLocation()
		// Sending NSNotification for MapDropViewController to update it's MapView
    print(locations.first?.coordinate.latitude)
		NSNotificationCenter.defaultCenter().postNotificationName("updateMap", object: nil)
		TrapManager.sharedInstance.explodeCheck()
	}

	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		switch status {
		case .NotDetermined:
			locationManager.requestAlwaysAuthorization()
			break
		case .AuthorizedWhenInUse:
			break
		case .AuthorizedAlways:
			startLocation()
			break
		case .Denied:
			// user denied your app access to Location Services, but can grant access from Settings.app
			NotificationManager.sharedInstance.showLocationSettingAlert()
			break
		default:
			break
		}
	}
}

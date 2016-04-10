//
//  MapDropViewController.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/9/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapDropViewController: UIViewController {

	@IBOutlet weak var map: MKMapView!
	override func viewDidLoad() {
		super.viewDidLoad()

		updateMapLocation()
	}

	func saveTrap() {
		let trapObj = PFObject(className: "Mine")
		trapObj["location"] = PFGeoPoint(location: Location.sharedInstance.lastLocation)
		trapObj["userId"] = "ioAAgU1VDc"
		trapObj.saveInBackground()
	}

	func updateMapLocation() {
		Location.sharedInstance.getLocation { (loc, error) in

			if error == nil {
				let center = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
				let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))

				if self.map != nil {
					self.map.setRegion(region, animated: true)
				}

				// let overlay = MKTileOverlay(URLTemplate: "http://www.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png")
				// overlay.canReplaceMapContent = true
				// self.map.addOverlay(overlay)
			} else {
				print(error)
			}
		}
	}

	func alert() {
		let alert = UIAlertController(title: "Booom", message: "You got Exploded!", preferredStyle: .Alert)
		self.presentViewController(alert, animated: true, completion: nil)
	}

	@IBAction func butLocation(sender: AnyObject) {
		updateMapLocation()
	}
	@IBAction func butDeploy(sender: AnyObject) {
		saveTrap()
	}
}

extension MapDropViewController: MKMapViewDelegate
{
//  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//    let renderer = MKTileOverlayRenderer(overlay:overlay)
//    return renderer
//  }
}
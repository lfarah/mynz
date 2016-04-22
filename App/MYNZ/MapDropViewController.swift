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

	// MARK: - Variables
	// MARK: Outlets
	@IBOutlet weak var map: MKMapView!
  @IBOutlet weak var lblCity: UILabel!

	// MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()

		updateMapLocation()

		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateMapLocation), name: "updateMap", object: nil)
    
	}

	func saveTrap() {
		let trapObj = PFObject(className: "Mine")
		trapObj["location"] = PFGeoPoint(location: Location.sharedInstance.locationManager.location)
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

				// Dark overlay not yet implemented
				// let overlay = MKTileOverlay(URLTemplate: "http://www.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png")
				// overlay.canReplaceMapContent = true
				// self.map.addOverlay(overlay)
			} else {
				print(error)
			}
		}
    
    Location.sharedInstance.getCity { (city) in
      self.lblCity.text = city
    }
	}

	@IBAction func butLocation(sender: AnyObject) {
		updateMapLocation()
	}
	@IBAction func butDeploy(sender: AnyObject) {
		saveTrap()
	}
}

//MARK: - MKMapViewDelegate
extension MapDropViewController: MKMapViewDelegate {
//  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//    let renderer = MKTileOverlayRenderer(overlay:overlay)
//    return renderer
//  }
}

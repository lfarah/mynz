//
//  MapDropViewController.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/9/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import MapKit

class MapDropViewController: UIViewController {

  @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
      updateMapLocation()
    }
  
  func updateMapLocation() {
    Location.sharedInstance.getLocation { (loc) in
      print(loc)
      let center = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
      
      self.map.setRegion(region, animated: true)
      //        let overlay = MKTileOverlay(URLTemplate: "http://www.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png")
      //        let overlay = MKTileOverlay(URLTemplate: "http://www.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png")
      //        overlay.canReplaceMapContent = true
      //        self.map.addOverlay(overlay)
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  @IBAction func butLocation(sender: AnyObject) {
    updateMapLocation()

  }
}

extension MapDropViewController:MKMapViewDelegate
{
//  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//    let renderer = MKTileOverlayRenderer(overlay:overlay)
//    return renderer
//  }
}
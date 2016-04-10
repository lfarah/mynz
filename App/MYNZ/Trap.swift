//
//  Trap.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/9/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class Trap: AnyObject {

	enum TrapType {
		case Mine
	}

	var location: CLLocation
	var type: TrapType
	var userId: String
  var objectId: String
  
  init(location: CLLocation, type: TrapType, userId: String, objectId: String) {
		self.location = location
		self.type = type
		self.userId = userId
    self.objectId = objectId
	}
  
  // When bomb explodes user, bomb is deleted
  func remove() {
    let query = PFQuery(className: "Mine")
    query.whereKey("objectId", equalTo: self.objectId)
    query.findObjectsInBackgroundWithBlock { (objects, error) in
      
      if error == nil {
        let obj = objects?.first
        obj?.deleteInBackground()
      }
    }
  }
}

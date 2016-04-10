//
//  Trap.swift
//  MYNZ
//
//  Created by Lucas Farah on 4/9/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import CoreLocation

class Trap: AnyObject {

	enum TrapType {
		case Mine
	}

	var location: CLLocation
	var type: TrapType
	var userId: String

	init(location: CLLocation, type: TrapType, userId: String) {
		self.location = location
		self.type = type
		self.userId = userId
	}
}

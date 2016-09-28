//
//  Location.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/28/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation

class Location {
    
    static var sharedInstance = Location()
    
    var lat: Double!
    var lon: Double!
    
    private init() {}
    
}

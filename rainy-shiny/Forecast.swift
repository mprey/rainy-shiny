//
//  Forecast.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/26/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation

class Forecast {
    
    var _date: String?
    var _highTemp: String?
    var _lowTemp: String?
    var _weatherType: String?
    
    var date: String {
        return _date == nil ? "" : _date
    }
    
    var highTemp: String {
        return _highTemp == nil ? "" : _highTemp
    }
    
    var lowTemp: String {
        return _lowTemp == nil ? "" : _lowTemp
    }
    
    var weatherType: String {
        return _weatherType == nil ? "" : _weatherType
    }
    
}

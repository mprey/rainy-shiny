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
    var _lowTemp: String = ""
    var _weatherType: String?
    
    init(dict: Dictionary<String, AnyObject>) {
        if let temp = dict["temp"] as? Dictionary<String, AnyObject> {
            if let high = temp["max"] as? Double {
                self._highTemp = "\(convertToFarenheit(kelvin: high))"
            }
            if let low = temp["min"] as? Double {
                self._lowTemp = "\(convertToFarenheit(kelvin: low))"
            }
        }
        
        if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
            if let weatherType = weather[0]["main"] as? String {
                self._weatherType = weatherType
            }
        }
        
        if let dateDouble = dict["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: dateDouble)
            self._date = unixDate.weekDay()
        }
    }
    
    var date: String {
        return _date == nil ? "" : _date!
    }
    
    var highTemp: String {
        return _highTemp == nil ? "" : _highTemp!
    }
    
    var lowTemp: String {
        return _lowTemp
    }
    
    var weatherType: String {
        return _weatherType == nil ? "" : _weatherType!
    }
}

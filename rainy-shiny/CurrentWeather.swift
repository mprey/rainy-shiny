//
//  CurrentWrather.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/22/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemperature: Double!
    
    var cityName: String {
        return _cityName == nil ? "" : _cityName
    }
    
    var weatherType: String {
        return _weatherType == nil ? "" : _weatherType
    }
    
    var currentTemperature: Double {
        return _currentTemperature == nil ? 0.0 : _currentTemperature
    }
    
    var date: String {
        if _date == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            let currentDate = dateFormatter.string(from: Date())
            self._date = "Today, \(currentDate)"
        }
        return _date
    }
    
    func getWeatherData(completed: @escaping kMPDownloadComplete) {
        Alamofire.request(TEMP_URL).responseJSON { response in
            if let JSON = response.result.value as? Dictionary<String, AnyObject> {
                self.parseJSON(json: JSON, completed: completed)
            } else {
                print(response.result.error?.localizedDescription)
                completed()
            }
        }
    }
    
    func parseJSON(json: Dictionary<String, AnyObject>, completed: kMPDownloadComplete) {
        if let cityName = json["name"] as? String {
            self._cityName = cityName
        }
        
        if let weatherDict = json["weather"] as? [Dictionary<String, AnyObject>] {
            if let weatherType = weatherDict[0]["main"] as? String {
                self._weatherType = weatherType
            }
        }
        
        if let tempDict = json["main"] as? Dictionary<String, AnyObject> {
            if let currentTemperature = tempDict["temp"] as? Double {
                let kelvin1 = (currentTemperature * (9/5) - 459.67)
                let kelvin2 = Double(round(10 * kelvin1 / 10))
                
                self._currentTemperature = kelvin2
            }
        }
        completed()
     }
    
}

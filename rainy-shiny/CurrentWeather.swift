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
        if _cityName == nil {
            return ""
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            return ""
        }
        return _weatherType
    }
    
    var currentTemperature: Double {
        if _currentTemperature == nil {
            return 0.0
        }
        return _currentTemperature
    }
    
    var date: String {
        if _date == nil {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    func getWeatherData(completed: kMPDownloadComplete) {
        Alamofire.request(TEMP_URL).responseJSON { response in
            if let JSON = response.result.value {
                print(JSON)
            } else {
                print(response)
            }
        }
        completed()
    }
    
}

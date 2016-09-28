//
//  ForecastHandler.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/27/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation
import Alamofire

class ForecastHandler {
    
    var forecasts = [Forecast]()
    
    func getForecastData(completed: @escaping kMPDownloadComplete) {
        //buildURL(lat: Location.sharedInstance.lat, lon: Location.sharedInstance.lon, current: false)
        print(TEMP_URL_FORECAST, "\n\n\n\n\n\n")
        Alamofire.request(TEMP_URL_FORECAST).responseJSON() { response in
            if let JSON = response.result.value as? Dictionary<String, AnyObject> {
                self.parseJSON(json: JSON, completed: completed)
            } else {
                print(response.result.error?.localizedDescription)
                completed()
            }
        }
    }
    
    func parseJSON(json: Dictionary<String, AnyObject>, completed: kMPDownloadComplete) {
        if let forecastList = json["list"] as? [Dictionary<String, AnyObject>] {
            for obj in forecastList {
                let forecast = Forecast(dict: obj)
                self.forecasts.append(forecast)
            }
        }
        self.forecasts.remove(at: 0) //remove current day as it is displayed in the other view
        completed()
    }
    
}

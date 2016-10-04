
//
//  Constants.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/22/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation

let kMPBaseURL = "http://api.openweathermap.org/data/2.5/weather?"
let kMPForecastURL = "http://api.openweathermap.org/data/2.5/forecast/daily?cnt=108&mode=json"

let kMPLatParam = "&lat="
let kMPLongParam = "&lon="
let kMPAppIDParam = "&appid="

let kMPAPIKey = "9af8924720095aeb9cd6f85390d5e1bd"

typealias kMPDownloadComplete = () -> ()

func getURL(forecast: Bool) -> String {
    var url = forecast ? kMPForecastURL : kMPBaseURL
    url.append("\(kMPLatParam)\(Location.sharedInstance.lat!)\(kMPLongParam)\(Location.sharedInstance.lon!)\(kMPAppIDParam)\(kMPAPIKey)")
    return url
}

func convertToFarenheit(kelvin: Double) -> Double {
    let kelvin1 = (kelvin * (9/5) - 459.67)
    let kelvin2 = Double(round(10 * kelvin1 / 10))
    
    return kelvin2
}

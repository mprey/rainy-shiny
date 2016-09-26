
//
//  Constants.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/22/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation

let kMPBaseURL = "http://api.openweathermap.org/data/2.5/weather?"

let kMPLatParam = "&lat="
let kMPLongParam = "&lon="
let kMPAppIDParam = "&appid="

let kMPAPIKey = "9af8924720095aeb9cd6f85390d5e1bd"

let TEMP_URL = "\(kMPBaseURL)\(kMPLatParam)40.712784\(kMPLongParam)-74.005941\(kMPAppIDParam)\(kMPAPIKey)"

typealias kMPDownloadComplete = () -> ()

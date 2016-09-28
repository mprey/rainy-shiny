//
//  WeatherCell.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/27/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    func updateCell(forecast: Forecast) {
        self.weatherImage?.image = UIImage(named: forecast.weatherType)
        self.weekDay?.text = forecast.date
        self.weatherType?.text = forecast.weatherType
        self.minTemp?.text = forecast.lowTemp
        self.maxTemp?.text = forecast.highTemp
    }

}

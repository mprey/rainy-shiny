//
//  WeatherViewController.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/20/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeatherHandler = CurrentWeatherHandler()
    var forecastHandler = ForecastHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.currentWeatherHandler.getWeatherData {
            self.forecastHandler.getForecastData {
                self.updateUI()
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Weather Cell", for: indexPath) as? WeatherCell {
            
        }
        return cell
    }
    
    func updateUI() {
        self.currentDateLabel?.text = self.currentWeatherHandler.date
        self.currentTemperatureLabel?.text = "\(self.currentWeatherHandler.currentTemperature)"
        self.currentCityLabel?.text = self.currentWeatherHandler._cityName
        self.currentWeatherLabel?.text = self.currentWeatherHandler.weatherType
        self.currentWeatherImage.image = UIImage(named: self.currentWeatherHandler.weatherType)
    }
    
}


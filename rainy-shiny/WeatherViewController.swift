//
//  WeatherViewController.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/20/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.currentWeather.getWeatherData {
            self.updateUI()
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
    
    func updateUI() {
        self.currentDateLabel?.text = self.currentWeather.date
        self.currentTemperatureLabel?.text = "\(self.currentWeather.currentTemperature)"
        self.currentCityLabel?.text = self.currentWeather._cityName
        self.currentWeatherLabel?.text = self.currentWeather.weatherType
        self.currentWeatherImage.image = UIImage(named: self.currentWeather.weatherType)
    }
    
}


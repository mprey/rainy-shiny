//
//  WeatherViewController.swift
//  rainy-shiny
//
//  Created by Mason Prey on 9/20/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeatherHandler = CurrentWeatherHandler()
    var forecastHandler = ForecastHandler()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var skipped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func fetchData() {
        Location.sharedInstance.lat = self.currentLocation?.coordinate.latitude
        Location.sharedInstance.lon = self.currentLocation?.coordinate.longitude
        self.currentWeatherHandler.getWeatherData {
            self.forecastHandler.getForecastData {
                self.updateUI()
                self.tableView.reloadData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            //self.currentLocation = self.locationManager.location
            //self.fetchData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        if (-(location.timestamp.timeIntervalSinceNow) > 5.0)  {
            return
        }
        
        if (location.horizontalAccuracy < 0) {
            return
        }
        
        self.currentLocation = location
        self.locationManager.stopUpdatingLocation()
        self.fetchData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastHandler.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Weather Cell", for: indexPath) as? WeatherCell {
            let forecast = self.forecastHandler.forecasts[indexPath.row]
            cell.updateCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
        
    }
    
    func updateUI() {
        self.currentDateLabel?.text = self.currentWeatherHandler.date
        self.currentTemperatureLabel?.text = "\(self.currentWeatherHandler.currentTemperature)\(kMPDegreeSymbol)"
        self.currentCityLabel?.text = self.currentWeatherHandler._cityName
        self.currentWeatherLabel?.text = self.currentWeatherHandler.weatherType
        self.currentWeatherImage.image = UIImage(named: self.currentWeatherHandler.weatherType)
    }
    
}


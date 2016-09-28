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
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startMonitoringSignificantLocationChanges()
        
        self.locationAuthStatus()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func fetchData() {
        print("GETTING DATA \n\n\n\n\n\n")
        self.currentWeatherHandler.getWeatherData {
            self.forecastHandler.getForecastData {
                self.updateUI()
                self.tableView.reloadData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.fetchData()
        } else {
            let alert = UIAlertController(title: "Error", message: "You must enable location services in Settings in order to use this app.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            print("UPDATING LOCATION\n\n\n\n\n\n")
            Location.sharedInstance.lat = currentLocation.coordinate.latitude
            Location.sharedInstance.lon = currentLocation.coordinate.longitude
            print(Location.sharedInstance.lat, Location.sharedInstance.lon, "\n\n\n\n\n")
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
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
        self.currentTemperatureLabel?.text = "\(self.currentWeatherHandler.currentTemperature)"
        self.currentCityLabel?.text = self.currentWeatherHandler._cityName
        self.currentWeatherLabel?.text = self.currentWeatherHandler.weatherType
        self.currentWeatherImage.image = UIImage(named: self.currentWeatherHandler.weatherType)
    }
    
}


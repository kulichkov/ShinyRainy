//
//  WeatherViewController.swift
//  ShinyRainy
//
//  Created by Mikhail Kulichkov on 10/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let currentWeather = CurrentWeather(latitude: 0.0, longitude: 0.0)
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        didSet {
            if currentLocation == nil { return }
            currentWeather.setCoordinates(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude)
            currentWeather.downloadWeatherDetails {
                self.updateUI()
            }
            currentWeather.downloadForecast {
                self.tableView.reloadData()
            }
        }
    }

    private func locationAuth() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuth()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    private func updateUI() {
        locationLabel.text = currentWeather.cityName
        let plusSign = currentWeather.currentTemp > 0 ? "+" : ""
        currentTempLabel.text = String(format:"\(plusSign)%.0f Cº", currentWeather.currentTemp)
        currentWeatherTypeLabel.text = currentWeather.weatherType
        dateLabel.text = currentWeather.date
        currentWeatherImage.image = currentWeather.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeather.forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let forecastCell = tableView.dequeueReusableCell(withIdentifier: "Weather Cell", for: indexPath) as? ForecastTableViewCell {
            forecastCell.fillForecastCell(forecast: currentWeather.forecasts[indexPath.row])
            return forecastCell
        }
        return UITableViewCell()
    }

}


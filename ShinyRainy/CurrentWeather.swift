//
//  CurrentWeather.swift
//  ShinyRainy
//
//  Created by Mikhail Kulichkov on 12/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import Foundation
import Alamofire

typealias Property = Dictionary<String, AnyObject>

class CurrentWeather {
    private var _cityName: String?
    private var _date: String?
    private var _weatherType: String?
    private var _currentTemp: Double?
    private var _image: UIImage?
    private var openWeather: OpenWeatherMap!
    private var _forecasts: [Forecast]?

    init(latitude:Double, longitude: Double) {
        self.openWeather = OpenWeatherMap(latitude: latitude, longitude: longitude)
    }

    func setCoordinates(latitude: Double, longitude:Double) {
        openWeather?.longitude = longitude
        openWeather?.latitude = latitude
    }

    var forecasts: [Forecast] {
        if _forecasts == nil { _forecasts = [Forecast]() }
        return _forecasts!
    }

    var image: UIImage {
        if _image == nil {
            _image = UIImage()
        }
        return _image!
    }
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName!
    }
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        _date = "Today, " + dateFormatter.string(from: Date())
        return _date!
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType!
    }
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp!
    }

    func downloadForecast(completed: @escaping () -> () ) {
        Alamofire.request(openWeather.getForecastURL!).responseJSON { response in
            if let result = response.result.value as? Property, let list = result["list"] as? [Property] {
                if !self.forecasts.isEmpty {
                    self._forecasts?.removeAll()
                }
                for eachForecast in list {
                    let forecast = Forecast(property: eachForecast)
                    self._forecasts?.append(forecast)
                }
            }
            completed()
        }
    }

    func downloadWeatherDetails(completed: @escaping () -> () ) {
        Alamofire.request(openWeather.getWeatherURL!).responseJSON { response in
            if let result = response.result.value as? Property {
                if let name = result["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = result["weather"] as? [Property] {
                    if let main = weather.first?["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                    if let icon = weather.first?["icon"] as? String {
                        let imageData = try! Data(contentsOf: URL(string: self.openWeather.imgURLPrefix + icon + self.openWeather.imgExtension)!)
                        self._image = UIImage(data: imageData)
                    }
                }
                if let main = result["main"] as? Property {
                    if let temp = main["temp"] as? Double {
                        let tempInCelsius = temp - 273.15
                        self._currentTemp = tempInCelsius
                    }
                }
            }
            completed()
        }
    }
}

extension Date {
    func weekdayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

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
    private var openWeather = OpenWeatherMap(latitude: 20.0, longitude: 20.0)

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

    func downloadWeatherDetails(completed: @escaping ()->() ) {
        Alamofire.request(openWeather.getURL!).responseJSON { response in
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

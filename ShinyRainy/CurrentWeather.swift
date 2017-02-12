//
//  CurrentWeather.swift
//  ShinyRainy
//
//  Created by Mikhail Kulichkov on 12/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    private var _cityName: String?
    private var _date: String?
    private var _weatherType: String?
    private var _currentTemp: Double?
    private var openWeather = OpenWeatherMap(latitude: 2.0, longitude: 2.0)

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

    func downloadWeatherDetails(completed: ()->() ) {
        Alamofire.request(openWeather.getURL!).responseJSON { response in
            print(response)
        }
    }
}

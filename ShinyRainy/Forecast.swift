//
//  Forecast.swift
//  ShinyRainy
//
//  Created by Mikhail Kulichkov on 13/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import Foundation

class Forecast {
    private let imgURLPrefix = "http://openweathermap.org/img/w/"
    private let imgExtension = ".png"
    private var _dayOfWeek: String?
    private var _weatherType: String?
    private var _highTemp: Double?
    private var _lowTemp: Double?
    private var _imageData: Data?

    var dayOfWeek: String {
        if _dayOfWeek == nil { _dayOfWeek = "" }
        return _dayOfWeek!
    }
    var weatherType: String {
        if _weatherType == nil { _weatherType = "" }
        return _weatherType!
    }
    var highTemp: Double {
        if _highTemp == nil { _highTemp = 0 }
        return _highTemp!
    }
    var lowTemp: Double {
        if _lowTemp == nil { _lowTemp = 0 }
        return _lowTemp!
    }
    var imageData: Data {
        if _imageData == nil { _imageData = Data() }
        return _imageData!
    }

    private func toCelsius(kelvinTemperature: Double) -> Double {
        return kelvinTemperature - 273.15
    }

    init(property: Property) {
        if let timeScince1970 = property["dt"] as? Double {
            let date = Date(timeIntervalSince1970: timeScince1970)
            self._dayOfWeek = date.weekdayName().capitalized
        }
        if let temp = property["temp"] as? Property {
            if let min = temp["min"] as? Double {
                self._lowTemp = self.toCelsius(kelvinTemperature: min)
            }
            if let max = temp["max"] as? Double {
                self._highTemp = self.toCelsius(kelvinTemperature: max)
            }
        }
        if let weather = property["weather"] as? [Property] {
            if let main = weather.first?["main"] as? String {
                self._weatherType = main.capitalized
            }
            if let icon = weather.first?["icon"] as? String {
                do {
                    self._imageData = try Data(contentsOf: URL(string: self.imgURLPrefix + icon + self.imgExtension)!)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    
}

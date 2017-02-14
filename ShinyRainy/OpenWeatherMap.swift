//
//  OpenWeatherMap.swift
//  ShinyRainy
//
//  Created by Mikhail Kulichkov on 12/02/17.
//  Copyright © 2017 Mikhail Kulichkov. All rights reserved.
//

import Foundation

fileprivate enum OpenWeatherMapError: Error {
    case invalidLongitude
    case invalidLatitude
}

struct OpenWeatherMap {
    let urlPrefix = "http://api.openweathermap.org/data/"
    let imgURLPrefix = "http://openweathermap.org/img/w/"
    let imgExtension = ".png"
    let apiVersion = "2.5"
    let urlWeatherPrefix = "/weather?"
    let urlDailyForecastPrefix = "/forecast/daily?"
    let numberOfDaysPrefix = "&cnt="
    let numberOfDays = 10
    let latPrefix = "lat="
    let lonPrefix = "&lon="
    let appIDPrefix = "&appid="
    private let appID = "2ee10853d63f5912293970201aa04a75"
    var latitude: Double
    var longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var getForecastURL: URL? {
        var urlString = urlPrefix + apiVersion + urlDailyForecastPrefix
        urlString.append(latPrefix + "\(latitude)")
        urlString.append(lonPrefix + "\(longitude)")
        urlString.append(numberOfDaysPrefix + "\(numberOfDays)" + appIDPrefix + appID)
        return URL(string: urlString)
    }

    var getWeatherURL: URL? {
        let urlString = urlPrefix + apiVersion + urlWeatherPrefix + latPrefix + "\(latitude)" + lonPrefix + "\(longitude)" + appIDPrefix + appID
        return URL(string: urlString)
    }


}

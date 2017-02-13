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
    let urlSuffix = "/weather?"
    let latPrefix = "lat="
    let lonPrefix = "&lon="
    let appIDPrefix = "&appid="
    private let appID = "2ee10853d63f5912293970201aa04a75"
    private var _latitude: Double
    private var _longitude: Double

    init(latitude: Double, longitude: Double) {
        _latitude = latitude
        _longitude = longitude
    }

    var getURL: URL? {
        let urlString = urlPrefix + apiVersion + urlSuffix + latPrefix + "\(_latitude)" + lonPrefix + "\(_longitude)" + appIDPrefix + appID
        return URL(string: urlString)
    }
}

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
    private let urlPrefix = "http://api.openweathermap.org/data/"
    private let apiVersion = "2.5"
    private let urlSuffix = "/weather?"
    private let latPrefix = "lat="
    private let lonPrefix = "&lon="
    private let appIDPrefix = "&appid="
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

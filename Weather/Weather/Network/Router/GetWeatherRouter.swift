//
//  GetWeatherRouter.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation
import CoreLocation

final class GetWeatherRouter: Router {

    enum Unit: String {
        case metric
        case imperial
    }

    internal init(coordinate: CLLocationCoordinate2D, unit: Unit, countOfPlace: Int) {
        self.coordinate = coordinate
        self.unit = unit
        self.countOfPlace = countOfPlace
    }

    var resource: String { "find" }
    let coordinate: CLLocationCoordinate2D
    let unit: Unit
    let countOfPlace: Int
    var parameters: [String: Any]? {
        var params = [String: Any]()
        params["lat"] = coordinate.latitude
        params["lon"] = coordinate.longitude
        params["units"] = unit.rawValue
        params["appid"] = Constants.weatherApiKey
        params["cnt"] = countOfPlace
        return params
    }
}

//
//  WeatherService.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation
import CoreLocation

final class WeatherService {
    internal init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    private let apiManager: ApiManager

    func getWeather(by coordinate: CLLocationCoordinate2D,
                    unit: GetWeatherRouter.Unit = .metric,
                    countOfPlace: Int = 11,
                    completion: @escaping (Response<ListOfWeatherModel>) -> Void) {
        let router = GetWeatherRouter(coordinate: coordinate, unit: unit, countOfPlace: countOfPlace)
        apiManager.makeRequest(parameters: router) { result in
            completion(result)
        }
    }

}

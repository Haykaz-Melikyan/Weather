//
//  WeatherModel.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation
struct ListOfWeatherModel: Decodable {
    let list: [WeatherModel]
    let count: Int
}
struct WeatherModel: Decodable {
    let main: Main?
    let visibility: Int?
    let name: String?
    let wind: Wind?
}

extension WeatherModel {

    struct Main: Decodable {
        let temp: Double?
        let tempMin: Double?
        let tempMax: Double?
        let pressure: Double?
        let humidity: Double?

        enum MainCodings: String, CodingKey {
            case temp, pressure, humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: MainCodings.self)
            temp = try container.decodeIfPresent(Double.self, forKey: .temp)
            tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin)
            tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax)
            pressure = try container.decodeIfPresent(Double.self, forKey: .pressure)
            humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)

        }
    }
}

extension WeatherModel {
    struct Wind: Decodable {
        let speed: Double?
    }
}



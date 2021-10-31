//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation
import CoreLocation
import RxRelay

private let currentTemperature = "current temperature"
private let maximumTemperature = "maximum temperature"
private let minimumTemperature = "minimum temperature"
private let humidity = "humidity"
private let pressure = "pressure"
private let visibility = "visibility"
private let speed = "speed"

final class WeatherListViewModel: BaseViewModel  {

    internal init(service: WeatherService ) {
        self.service = service
        super.init()
    }
    private let service: WeatherService
    let dataSource = BehaviorRelay<[WeatherListCellViewModel]?>(value: nil)
    private var data: ListOfWeatherModel?

    func fetch(coordinate: CLLocationCoordinate2D) {
        service.getWeather(by: coordinate) { [weak self] response in
            guard let data = self?.responseHandler(response: response),
                  let strongSelf = self else { return }
            strongSelf.dataSource.accept(strongSelf.setupDataSource(with: data))
            strongSelf.data = data
        }
    }

    private func setupDataSource(with data: ListOfWeatherModel) -> [WeatherListCellViewModel] {
        let dataSource = data.list.map { model -> WeatherListCellViewModel in
            return createWeatherListCellViewModel(from: model)
        }
        return dataSource
    }

    private func createWeatherListCellViewModel(from model: WeatherModel) -> WeatherListCellViewModel {

        let placeNameText = model.name ?? ""
        var currentTempText = ""
        var tempMinimumText = ""
        var tempMaximumText = ""
        if let temp = model.main?.temp?.format(f: ".1") {
            currentTempText = currentTemperature + ": \(temp)"
        }
        if let tempMinText = model.main?.tempMin?.format(f: ".1") {
            tempMinimumText = minimumTemperature + ": \(tempMinText)"
        }
        if let tempMaxText = model.main?.tempMax?.format(f: ".1") {
            tempMaximumText = maximumTemperature + ": \(tempMaxText)"
        }
        return WeatherListCellViewModel(placeNameText: placeNameText,
                                        currentTemptText: currentTempText,
                                        minTempText: tempMinimumText,
                                        maxTemptText: tempMaximumText)
    }

    func createViewModelForWeatherDetail(at index: Int) -> WeatherDetailViewModel? {
        guard let dataSource = dataSource.value, let data = data else { return nil }
        let cellModel = dataSource[index]
        let item = data.list[index]
        var humidityText = ""
        var pressureText = ""
        var visibilityText = ""
        var windSpeedText = ""
        if let formattedHumidity = item.main?.humidity?.format(f: ".1") {
            humidityText = humidity + ": \(formattedHumidity) %"
        }
        if let formattedPressure = item.main?.pressure?.format(f: ".1") {
            pressureText = pressure + ": \(formattedPressure) hPa"
        }
        if let visibilityValue = item.visibility {
            visibilityText = visibility + "\(visibilityValue) km"
        }
        if let windSpeed = item.wind?.speed {
            windSpeedText = speed + ": \(windSpeed) km/h"
        }
        return WeatherDetailViewModel(windSpeedText: windSpeedText,
                                      visibilityText: visibilityText,
                                      humidityText: humidityText, pressureText: pressureText, listCellModel: cellModel)
    }
    

}

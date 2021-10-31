//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by Haykaz Melikyan on 31.10.21.
//

import Foundation

final class WeatherDetailViewModel: WeatherListCellViewModel {

    internal init(windSpeedText: String,
                  visibilityText: String,
                  humidityText: String,
                  pressureText: String,
                  listCellModel: WeatherListCellViewModel ){
        self.windSpeedText = windSpeedText
        self.visibilityText = visibilityText
        self.humidityText = humidityText
        self.pressureText = pressureText
        super.init(placeNameText: listCellModel.placeNameText,
                   currentTemptText: listCellModel.currentTemptText,
                   minTempText: listCellModel.minTempText,
                   maxTemptText: listCellModel.maxTemptText)
    }
    
    let windSpeedText: String
    let visibilityText: String
    let humidityText: String
    let pressureText: String

    
}

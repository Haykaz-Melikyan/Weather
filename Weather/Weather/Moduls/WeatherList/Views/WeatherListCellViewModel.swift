//
//  WeatherListCellViewModel.swift
//  Weather
//
//  Created by Haykaz Melikyan on 30.10.21.
//

import Foundation

class WeatherListCellViewModel {
    internal init(placeNameText: String,
                  currentTemptText: String,
                  minTempText: String,
                  maxTemptText: String) {
        self.placeNameText = placeNameText
        self.currentTemptText = currentTemptText
        self.minTempText = minTempText
        self.maxTemptText = maxTemptText
    }
    let placeNameText: String
    let currentTemptText: String
    let minTempText: String
    let maxTemptText: String

}

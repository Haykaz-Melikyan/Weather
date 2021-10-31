//
//  WeatherListCell.swift
//  Weather
//
//  Created by Haykaz Melikyan on 30.10.21.
//

import UIKit

final class WeatherListCell: UITableViewCell {

    @IBOutlet private weak var placeNameLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!

    var viewModel: WeatherListCellViewModel? {
        didSet {
            placeNameLabel.text = viewModel?.placeNameText
            currentTempLabel.text = viewModel?.currentTemptText
            maxTempLabel.text = viewModel?.maxTemptText
            minTempLabel.text = viewModel?.minTempText
        }
    }

}

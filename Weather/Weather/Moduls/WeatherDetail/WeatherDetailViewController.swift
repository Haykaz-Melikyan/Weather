//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Haykaz Melikyan on 31.10.21.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var visibilityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!

    var viewModel: WeatherDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
    }

    private func setUi() {
        guard let viewModel = viewModel else { return }
        title = viewModel.placeNameText
        currentTempLabel.isHidden = viewModel.currentTemptText.isEmpty
        maxTempLabel.isHidden = viewModel.maxTemptText.isEmpty
        minTempLabel.isHidden = viewModel.minTempText.isEmpty
        humidityLabel.isHidden = viewModel.humidityText.isEmpty
        pressureLabel.isHidden = viewModel.pressureText.isEmpty
        visibilityLabel.isHidden = viewModel.visibilityText.isEmpty
        windSpeedLabel.isHidden = viewModel.windSpeedText.isEmpty
        currentTempLabel.text = viewModel.currentTemptText
        maxTempLabel.text = viewModel.maxTemptText
        minTempLabel.text = viewModel.minTempText
        humidityLabel.text = viewModel.humidityText
        pressureLabel.text = viewModel.pressureText
        visibilityLabel.text = viewModel.visibilityText
        windSpeedLabel.text = viewModel.windSpeedText
    }


}

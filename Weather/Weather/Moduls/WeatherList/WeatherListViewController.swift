//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import UIKit
import CoreLocation
private let titleText = "Weather"
final class WeatherListViewController: BaseViewController<WeatherListViewModel> {

    @IBOutlet private weak var tableView: UITableView!
    private var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleText
        let weatherService = WeatherService(apiManager: ApiManager())
        viewModel = WeatherListViewModel(service: weatherService)
        setupLocationManager()
        bindViewModel()
    }

    lazy var permissionDeniedAlert: UIAlertController = {
        let alert = UIAlertController(title: "you have not permission, so we can't show your current location weather",
                                      message: "please select ok for enable permission from settings",
                                      preferredStyle: .alert)
        let openSettingsAction = UIAlertAction(title: "ok", style: .default) { (alert) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(openSettingsAction)
        alert.addAction(cancelAction)
        return alert
    }()

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.dataSource
            .subscribe(onNext: {  [weak self] data in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
    }

    private func checkLocationPermission() {
        guard let locationManager = self.locationManager else { return }
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined :
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorized, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                self.present(permissionDeniedAlert, animated: true, completion: nil)
            default:
                assertionFailure("CLLocationManager.authorizationStatus not handled case ")
            }
        }
    }

}

extension WeatherListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            guard viewModel.dataSource.value == nil else { return }
            viewModel.fetch(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                               longitude: location.coordinate.longitude))
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    locationManager?.startUpdatingLocation()
                }
            }
        } else if status == .denied {
            self.present(permissionDeniedAlert, animated: true, completion: nil)
        }
    }
}



extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.className) as? WeatherListCell,
              let dataSource = viewModel.dataSource.value else {
            return UITableViewCell()
        }
        cell.viewModel = dataSource[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = viewModel.createViewModelForWeatherDetail(at: indexPath.row) else { return }
        let storyBoard = self.storyboard
        let weatherDetailViewController = storyBoard?.instantiateViewController(withIdentifier: WeatherDetailViewController.className) as! WeatherDetailViewController
        weatherDetailViewController.viewModel = selectedItem
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }

}


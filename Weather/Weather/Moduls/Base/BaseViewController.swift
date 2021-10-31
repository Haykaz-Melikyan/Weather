//
//  BaseViewController.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController, ActivityLoading {
    var activityIndicator: UIView?

    var withBackground: Bool { true }

    var smallViewBackgroundColor: UIColor?

    var backgroundColor: UIColor?

    var indicatorContainerView: UIView?

    var viewModel: T!
    let disposeBag = DisposeBag()

    var infoViewContainer: UIView { self.view }
    
     func bindLoader() {
        viewModel.isLoading
          .subscribe(onNext: {  [weak self] isLoading in
              guard let isLoading = isLoading else { return }
              isLoading ? self?.showLoader() : self?.hideLoader()
          })
          .disposed(by: disposeBag)
    }

    func bindViewModel() {
        bindLoader()
        bindError()
    }

    private func bindError() {
        viewModel.showError
            .subscribe(onNext: {  [weak self] error in
                guard let error = error else { return }
                self?.viewModel.isLoading.accept(false)
                let alert = UIAlertController(title: "oops_error", message: error.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}

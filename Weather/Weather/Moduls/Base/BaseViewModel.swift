//
//  BaseViewModel.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation
import RxRelay

class BaseViewModel {

    var isLoading = BehaviorRelay<Bool?>(value: false)
    var showError = BehaviorRelay<ServerError?>(value: nil)

    func responseHandler<T>(response: Response<T>) -> T? {
       switch response {
       case .failure(let error):
           showError.accept(error)
       case .success(let data):
           showError.accept(nil)
           return data
       }
       return nil
    }
    
}

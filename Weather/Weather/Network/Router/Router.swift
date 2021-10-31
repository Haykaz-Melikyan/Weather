//
//  Router.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation
enum Method: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol Router {
    var parameters: [String: Any]? { get }
    var resource: String { get }
    var method: Method { get }
    var headers: [String: String] { get }
    var baseUrl: String { get }
}

extension Router {
    var baseUrl: String { Constants.Links.baseURL }
    var parameters: [String: Any]? { nil }
    var method: Method { .get }
    var headers: [String: String] { [:] }
}

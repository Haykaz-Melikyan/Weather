//
//  ApiManager.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import Foundation

typealias Response<T> = Result<T?,ServerError>


final class ServerError: ExpressibleByStringLiteral, Error {
    typealias StringLiteralType = String
    let errorMessage: String
    var code: Int?

    public required init(stringLiteral value: StringLiteralType) {
        errorMessage = value
    }

    public init(error: Error, code: Int?) {
        self.errorMessage = error.localizedDescription
        self.code = code
    }

    public init(message: String, code: Int?) {
        self.errorMessage = message
        self.code = code
    }
}

struct NilData: Decodable {}

final class ApiManager {

    static let trustedSession = TrustedSessionManager().session

    public func makeRequest<T: Decodable>(parameters: Router, onCompletion: @escaping ((Response<T>) -> Void)) {
        let urlString = "\(parameters.baseUrl)\(parameters.resource)"
        guard let url = URL(string: urlString) else {
            onCompletion(.failure("invalid url"))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = parameters.method.rawValue

        if parameters.method.rawValue == Method.get.rawValue {
            var urlComponents = URLComponents(string: urlString)
            var queryItems = [URLQueryItem]()
            if let params = parameters.parameters {
                for (key, value) in params {
                    queryItems.append(URLQueryItem(name: key, value: "\(value)"))
                }
                urlComponents?.queryItems = queryItems
                request = URLRequest(url: (urlComponents?.url)!)
            }
        }

        // Set the POST body for the request
        if let params = parameters.parameters, parameters.method.rawValue != Method.get.rawValue {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        parameters.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        print(request.url ?? "")
        let task = Self.trustedSession.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard error == nil else {
                onCompletion(.failure((ServerError(error: error!, code: (error as NSError?)?.code))))
                return
            }

            guard  let data = data else {
                onCompletion(.failure(ServerError(stringLiteral: "Response is empty")))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print("response \(json)")
            }

            do {
                let objectResponse: T = try self.parsData(data: data)
                onCompletion(.success(objectResponse))
            } catch {
                print("Parsing error \(error)")
                onCompletion(.failure(ServerError(error: error, code: 0)))
            }
        })
        task.resume()
    }


    private  func parsData<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

}

private extension ApiManager {
    final class TrustedSessionManager: NSObject, URLSessionDelegate {
        lazy var session: URLSession = {[weak self] in
            let configuration = URLSessionConfiguration.default
            return URLSession(configuration: configuration,
                              delegate: self, delegateQueue: OperationQueue.main)
        }()
        public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
            let trust = challenge.protectionSpace.serverTrust
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, trust != nil ? URLCredential(trust: trust!) : nil)
        }
    }
}

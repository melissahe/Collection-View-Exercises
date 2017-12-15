//
//  NetworkHelper.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(url: String)
    case badImageURL(url: String)
    case badImageData
    case badStatusCode(code: Int)
    case couldNotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    func performDataTask(with url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error as? URLError {
                    switch error {
                    case URLError.notConnectedToInternet:
                        errorHandler(AppError.noInternet)
                    default:
                        errorHandler(AppError.other(rawError: error))
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        errorHandler(AppError.badStatusCode(code: response.statusCode))
                    }
                }
                
                if let data = data {
                    completionHandler(data)
                }
            }
        }.resume()
    }
    
}

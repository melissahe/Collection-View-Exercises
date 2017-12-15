//
//  CriticAPIClient.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class CriticAPIClient {
    private init() {}
    static let manager = CriticAPIClient()
    private let apiKey = "f17a6f246cf34666b4ccbf18bcb00469"
    func getCritics(completionHandler: @escaping ([Critic]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlString = "https://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badURL(url: urlString))
            return
        }
        
        NetworkHelper.manager.performDataTask(
            with: url,
            completionHandler: { (data) in
                do {
                    let criticsWrapper = try JSONDecoder().decode(CriticResultsWrapper.self, from: data)
                    
                    let critics = criticsWrapper.results
                    
                    completionHandler(critics)
                } catch let error {
                    errorHandler(AppError.couldNotParseJSON(rawError: error))
                }
                
        },
            errorHandler: errorHandler)
    }
}

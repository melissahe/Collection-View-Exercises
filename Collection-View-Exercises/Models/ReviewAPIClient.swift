//
//  ReviewAPIClient.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import UIKit

class ReviewAPIClient {
    private init() {}
    static let manager = ReviewAPIClient()
    private let apiKey = "f17a6f246cf34666b4ccbf18bcb00469"
    func getReviews(for critic: String, completionHandler: @escaping ([Review]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlString = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=\(apiKey)&reviewer=\(critic)"
        
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badImageURL(url: urlString))
            
            return
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            do {
                let reviews = try JSONDecoder().decode(ReviewResultsWrapper.self, from: data)
                
                completionHandler(reviews.results)
            } catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }, errorHandler: errorHandler)
    }
}

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
    func getReviews(from urlString: String, completionHandler: @escaping ([Review]) -> Void, errorHandler: @escaping (Error) -> Void) {
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

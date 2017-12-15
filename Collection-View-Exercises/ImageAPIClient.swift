//
//  ImageAPIClient.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlString: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badImageURL(url: urlString))
            return
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            guard let image = UIImage(data: data) else {
                errorHandler(AppError.badImageData)
                
                return
            }
            
            completionHandler(image)
        }, errorHandler: errorHandler)
    }
}

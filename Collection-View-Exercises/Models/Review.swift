//
//  Review.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct ReviewResultsWrapper {
    let results: [Review]
}

struct Review: Codable {
    let title: String
    let multimedia: MultimediaWrapper?
    
    enum CodingKeys: String, CodingKey {
        case title = "display_title"
        case multimedia
    }
    
}

struct MultimediaWrapper: Codable {
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case link = "src"
    }
}

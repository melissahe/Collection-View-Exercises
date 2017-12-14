//
//  Critic.swift
//  Collection-View-Exercises
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let results: [Critic]
}

struct Critic: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
    }
}

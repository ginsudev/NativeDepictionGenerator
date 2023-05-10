//
//  Screenshots.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

struct Screenshots: Codable {
    let screenshots: [String]
    
    enum CodingKeys: String, CodingKey {
        case screenshots
    }
}

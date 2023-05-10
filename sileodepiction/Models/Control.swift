//
//  Control.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

struct Control: Codable {
    let packageName: String
    let name: String
    let version: String
    let architecture: String
    let description: String
    let maintainer: String
    let author: String
    let section: String
    let depends: String

    enum CodingKeys: String, CodingKey {
        case packageName = "Package"
        case name = "Name"
        case version = "Version"
        case architecture = "Architecture"
        case description = "Description"
        case maintainer = "Maintainer"
        case author = "Author"
        case section = "Section"
        case depends = "Depends"
    }
}

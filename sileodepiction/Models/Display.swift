//
//  Display.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

struct Display: Codable {
    let contact: Contact
    let information: Information
    let changelog: [ChangelogEntry]
}

extension Display {
    struct Contact: Codable {
        let twitter: String
        let discord: String
    }

    struct Information: Codable {
        let description: String
        let sourceCodeLink: String

        enum CodingKeys: String, CodingKey {
            case description
            case sourceCodeLink = "source_code_link"
        }
    }

    struct ChangelogEntry: Codable {
        let date: String
        let versionNumber: String
        let changes: String

        enum CodingKeys: String, CodingKey {
            case date
            case versionNumber = "version_number"
            case changes
        }
    }
}

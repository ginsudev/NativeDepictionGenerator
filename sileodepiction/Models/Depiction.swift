//
//  Depiction.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

enum DepictionClass: String, Codable {
    case depictionTabView = "DepictionTabView"
    case depictionStackView = "DepictionStackView"
    case depictionSpacerView = "DepictionSpacerView"
    case depictionButtonView = "DepictionButtonView"
    case depictionScreenshotsView = "DepictionScreenshotsView"
    case depictionMarkdownView = "DepictionMarkdownView"
    case depictionSeparatorView = "DepictionSeparatorView"
    case depictionTableButtonView = "DepictionTableButtonView"
    case depictionHeaderView = "DepictionHeaderView"
    case depictionTableTextView = "DepictionTableTextView"
    case depictionSubheaderView = "DepictionSubheaderView"
    case depictionLayerView = "DepictionLayerView"
}

struct DepictionTabView: Codable {
    let minVersion: String
    let depictionClass: DepictionClass
    let headerImage: String
    let tintColor: String
    let tabs: [DepictionStackView]

    enum CodingKeys: String, CodingKey {
        case minVersion
        case depictionClass = "class"
        case headerImage
        case tintColor
        case tabs
    }
}

struct DepictionStackView: Codable {
    let depictionClass: DepictionClass
    let tabname: String
    let views: [DepictionView]

    enum CodingKeys: String, CodingKey {
        case depictionClass = "class"
        case tabname
        case views
    }
}

struct DepictionView: Codable {
    let depictionClass: DepictionClass
    let spacing: Int?
    let text: String?
    let action: String?
    let yPadding: Int?
    let itemCornerRadius: Int?
    let itemSize: String?
    let screenshots: [DepictionScreenshot]?
    let markdown: String?
    let useSpacing: Bool?
    let title: String?
    let alignment: Int?
    let useBoldText: Bool?
    let views: [DepictionView]?

    enum CodingKeys: String, CodingKey {
        case depictionClass = "class"
        case spacing
        case text
        case action
        case yPadding
        case itemCornerRadius
        case itemSize
        case screenshots
        case markdown
        case useSpacing
        case title
        case alignment
        case useBoldText
        case views
    }
    
    init(
        depictionClass: DepictionClass,
        spacing: Int? = nil,
        text: String? = nil,
        action: String? = nil,
        yPadding: Int? = nil,
        itemCornerRadius: Int? = nil,
        itemSize: String? = nil,
        screenshots: [DepictionScreenshot]? = nil,
        markdown: String? = nil,
        useSpacing: Bool? = nil,
        title: String? = nil,
        alignment: Int? = nil,
        useBoldText: Bool? = nil,
        views: [DepictionView]? = nil
    ) {
        self.depictionClass = depictionClass
        self.spacing = spacing
        self.text = text
        self.action = action
        self.yPadding = yPadding
        self.itemCornerRadius = itemCornerRadius
        self.itemSize = itemSize
        self.screenshots = screenshots
        self.markdown = markdown
        self.useSpacing = useSpacing
        self.title = title
        self.alignment = alignment
        self.useBoldText = useBoldText
        self.views = views
    }
}

struct DepictionScreenshot: Codable {
    let url: String
    let fullSizeURL: String
    let accessibilityText: String

    enum CodingKeys: String, CodingKey {
        case url
        case fullSizeURL
        case accessibilityText
    }
}

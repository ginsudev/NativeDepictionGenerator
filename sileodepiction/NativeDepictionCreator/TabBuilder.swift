//
//  TabBuilder.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

// MARK: - Internal

extension NativeDepictionCreator {
    enum Tab {
        case details(display: Display, control: Control, screenshots: Screenshots)
        case changes(display: Display)
        case contact(display: Display, control: Control)
    }
    
    struct TabBuilder {
        static func tab(_ tab: Tab) -> DepictionStackView {
            switch tab {
            case let .details(display, control, screenshots):
                return buildDetails(
                    display: display,
                    control: control,
                    screenshots: screenshots
                )
            case let .changes(display):
                return buildChanges(display: display)
            case let .contact(display, control):
                return buildContact(
                    display: display,
                    control: control
                )
            }
        }
    }
}

// MARK: - Tabs

private extension NativeDepictionCreator.TabBuilder {
    typealias Constants = NativeDepictionCreator.Constants
    
    static func buildDetails(
        display: Display,
        control: Control,
        screenshots: Screenshots
    ) -> DepictionStackView {
        .init(
            depictionClass: .depictionStackView,
            tabname: "Details",
            views: [
                .init(depictionClass: .depictionSpacerView, spacing: 12),
                .init(
                    depictionClass: .depictionButtonView,
                    text: Constants.donateText,
                    action: Constants.donateLink,
                    yPadding: 10
                ),
                .init(
                    depictionClass: .depictionScreenshotsView,
                    itemCornerRadius: 6,
                    itemSize: "{160, 346}",
                    screenshots: depictionScreenshots(
                        id: control.packageName,
                        screenshots: screenshots
                    )
                ),
                .init(
                    depictionClass: .depictionMarkdownView,
                    markdown: display.information.description
                )
            ]
            +
            sourceCodeSection(link: display.information.sourceCodeLink)
            +
            [
                .init(
                    depictionClass: .depictionHeaderView,
                    title: "Extra information"
                ),
                .init(
                    depictionClass: .depictionTableTextView,
                    text: control.version,
                    title: "Version"
                ),
                .init(
                    depictionClass: .depictionTableTextView,
                    text: "Free",
                    title: "Price"
                ),
                .init(
                    depictionClass: .depictionTableTextView,
                    text: control.author,
                    title: "Developer"
                ),
                .init(
                    depictionClass: .depictionTableButtonView,
                    action: "https://ginsu.dev/repo/depictions/index.html?packageId=\(control.packageName)",
                    title: "View web depiction"
                )
            ]
        )
    }
    
    static func buildChanges(
        display: Display
    ) -> DepictionStackView {
        .init(
            depictionClass: .depictionStackView,
            tabname: "Changes",
            views: display.changelog
                .reversed()
                .flatMap {
                    changelogRow(changeEntry: $0)
                }
        )
    }
    
    static func buildContact(
        display: Display,
        control: Control
    ) -> DepictionStackView {
        .init(
            depictionClass: .depictionStackView,
            tabname: "Contact",
            views: [
                .init(
                    depictionClass: .depictionTableButtonView,
                    action: display.contact.discord,
                    title: "Discord"
                ),
                .init(
                    depictionClass: .depictionTableButtonView,
                    action: "https://twitter.com/\(display.contact.twitter)",
                    title: "Twitter"
                )
            ]
        )
    }
}

// MARK: - Computed sections

private extension NativeDepictionCreator.TabBuilder {
    static func changelogRow(changeEntry: Display.ChangelogEntry) -> [DepictionView] {
        [
            .init(
                depictionClass: .depictionLayerView,
                views: [
                    .init(
                        depictionClass: .depictionSubheaderView,
                        title: changeEntry.versionNumber,
                        alignment: 0,
                        useBoldText: true
                    ),
                    .init(
                        depictionClass: .depictionSubheaderView,
                        title: changeEntry.date,
                        alignment: 2
                    ),
                ]
            ),
            .init(
                depictionClass: .depictionMarkdownView,
                markdown: changeEntry.changes,
                useSpacing: true
            ),
            .init(
                depictionClass: .depictionSpacerView,
                spacing: 12
            )
        ]
    }
    
    static func sourceCodeSection(link: String) -> [DepictionView] {
        if link.isEmpty {
            return [
                .init(depictionClass: .depictionSeparatorView),
            ]
        } else {
            return [
                .init(depictionClass: .depictionSeparatorView),
                .init(
                    depictionClass: .depictionTableButtonView,
                    action: link,
                    title: "View source code"
                ),
                .init(depictionClass: .depictionSeparatorView)
            ]
        }
    }
    
    static func depictionScreenshots(id: String, screenshots: Screenshots) -> [DepictionScreenshot] {
        screenshots.screenshots
            .map {
                let url = "\(Constants.api)/\(id)/screenshots/\($0)"
                return .init(
                    url: url,
                    fullSizeURL: url,
                    accessibilityText: "Screenshot"
                )
            }
    }
}

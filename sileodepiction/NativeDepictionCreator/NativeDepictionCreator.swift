//
//  NativeDepictionCreator.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

final class NativeDepictionCreator {
    func parse(
        displayPath: String,
        controlPath: String,
        screenshotsPath: String
    ) {
        do {
            guard let displayData = try? String(contentsOfFile: displayPath).data(using: .utf8),
                  let controlData = try String(contentsOfFile: controlPath).data(using: .utf8),
                  let screenshotsData = try String(contentsOfFile: screenshotsPath).data(using: .utf8)
            else { throw URLError(.dataNotAllowed) }
            
            let display = try object(data: displayData, type: Display.self)
            let control = try object(data: controlData, type: Control.self)
            let screenshots = try object(data: screenshotsData, type: Screenshots.self)
            
            let depiction = buildDepiction(
                display: display,
                control: control,
                screenshots: screenshots
            )
            printResult(depiction: depiction)
        } catch {
            print(error)
        }
    }
}

private extension NativeDepictionCreator {
    func object<Object: Codable>(data: Data, type: Object.Type) throws -> Object {
        let decoder = JSONDecoder()
        let result = try decoder.decode(type.self, from: data)
        return result
    }
    
    func buildDepiction(
        display: Display,
        control: Control,
        screenshots: Screenshots
    ) -> DepictionTabView {
        .init(
            minVersion: Constants.minVersion,
            depictionClass: .depictionTabView,
            headerImage: "\(Constants.api)/\(control.packageName)/banner.png",
            tintColor: Constants.tintColor,
            tabs: [
                TabBuilder.tab(.details(display: display, control: control, screenshots: screenshots)),
                TabBuilder.tab(.changes(display: display)),
                TabBuilder.tab(.contact(display: display, control: control))
            ]
        )
    }
    
    func printResult(depiction: DepictionTabView) {
        if let data = try? JSONEncoder().encode(depiction),
           let string = String(data: data, encoding: .utf8) {
            print(string)
        }
    }
}

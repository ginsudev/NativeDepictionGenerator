//
//  main.swift
//  sileodepiction
//
//  Created by Noah Little on 9/5/2023.
//

import Foundation

// Start
if CommandLine.arguments.count == 4 {
    let displayPath = CommandLine.arguments[1]
    let controlPath = CommandLine.arguments[2]
    let screenshotsPath = CommandLine.arguments[3]
    let depictionCreator = NativeDepictionCreator()
    depictionCreator.parse(
        displayPath: displayPath,
        controlPath: controlPath,
        screenshotsPath: screenshotsPath
    )
} else {
    print("bad args \(CommandLine.arguments)")
}

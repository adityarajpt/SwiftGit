//
//  SwiftGit.swift
//
//
//  Created by Aditya Rajput on 20/08/24.
//

import ArgumentParser
import Foundation

@main
struct SwiftGit: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A experimental alternative to git.",
        subcommands: [InitRepo.self],
        defaultSubcommand: InitRepo.self)
}

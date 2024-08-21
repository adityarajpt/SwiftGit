//
//  Init.swift
//
//
//  Created by Aditya Rajput on 20/08/24.
//

import Foundation
import ArgumentParser

extension SwiftGit {
    
    struct InitRepo: ParsableCommand {
        static let configuration
        = CommandConfiguration(abstract: "Print the sum of the values.", aliases: ["init"])
        
        // find a way to retrieve this in a better way
        private static let delimitor = "/"
        
        @Option(help: "Path to create sgit repo")
        public var path: String? = nil
        
        public func run() throws {
            try self.fileAccess()
        }
        
        func fileAccess() throws {
            let fileManager = FileManager()
            guard OSHelpers.haveSGitAtCurrentPath(fileManager: fileManager) == false else {
                print("sGit repo already exists")
                return
            }
            
            // Create sgit files and directory
            
            // 1. Create /.sgit/ directory
            try fileManager.createDirectory(atPath: OSHelpers.sGitDirectoryPath(fileManager: fileManager, path: self.path), withIntermediateDirectories: path != nil)
            
            // 2. Create SubDirectories
            
            // Objects
            let objectsPath = OSHelpers.sGitDirectoryPath(fileManager: fileManager, path: self.path) + Self.delimitor + "objects"
            try fileManager.createDirectory(atPath: objectsPath, withIntermediateDirectories: false)
            
            // Refs
            let refsPath = OSHelpers.sGitDirectoryPath(fileManager: fileManager, path: self.path) + Self.delimitor + "refs"
            try fileManager.createDirectory(atPath: refsPath, withIntermediateDirectories: false)
            
            // HEAD
            
            
            // Config
            
            
            // Description
            
            
        }
    }
}

// swift run --package-path "./swift-experimens/" sgit init --path "test"

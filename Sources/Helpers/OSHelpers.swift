//
//  OSHelpers.swift
//
//
//  Created by Aditya Rajput on 20/08/24.
//

import Foundation

class OSHelpers {
    
    enum SGitFolderError: Error {
        case folderNotFound
        case directoryReadError(Error)
    }

    static func findSGitFolder(fileManager: FileManager) throws -> URL {
        var currentDirectory = URL(fileURLWithPath: fileManager.currentDirectoryPath)
        while currentDirectory.path != "/" {
            // Attempt to get the list of directories in the current directory
            do {
                let directories = try fileManager.contentsOfDirectory(at: currentDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                
                // Check if any directory has the .sgit extension
                if let sgitFolder = directories.first(where: { $0.hasDirectoryPath && $0.pathExtension == "sgit" }) {
                    return sgitFolder
                }
            } catch {
                throw SGitFolderError.directoryReadError(error)
            }
            
            // Move up one directory level
            currentDirectory.deleteLastPathComponent()
        }

        // If no .sgit folder was found, throw an error
        throw SGitFolderError.folderNotFound
    }
    
    static func haveSGitAtCurrentPath(fileManager: FileManager) -> Bool {
        let sGitPath = fileManager.currentDirectoryPath
        return Self.haveSGitAtPath(fileManager: fileManager, path: sGitPath)
    }
    
    static func haveSGitAtPath(fileManager: FileManager, path: String) -> Bool {
        let newPath = path + "/.sgit"
        if fileManager.fileExists(atPath: newPath) == true {
            return true
        } else {
            return false
        }
    }
    
    static func sGitDirectoryPath(fileManager: FileManager, path: String? = nil) -> String {
        if let path {
            return fileManager.currentDirectoryPath + "/" + path + "/.sgit"
        } else {
            return fileManager.currentDirectoryPath + "/" + ".sgit"
        }
    }
}

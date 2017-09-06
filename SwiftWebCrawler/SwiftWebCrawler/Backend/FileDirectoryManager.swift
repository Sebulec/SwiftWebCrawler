//
//  FileDirectoryManager.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Cocoa

class FileDirectoryManager: NSObject {
    static let dirName = "WebCrawler"
    static let fileManager = FileManager.default
    
    class func prepare() {
        clearDirectoryWithName()
        createDirectoryIfNotExists()
    }
    
    class func createDirectoryIfNotExists() {
        do {
            try fileManager.createDirectory(atPath: getDirectoryPath().path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
    }
    
    class func clearDirectoryWithName() {
        do {
            try fileManager.removeItem(atPath: getDirectoryPath().path)
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    class func getDirectoryPath() -> URL {
        let documentsDirectory = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let tempFolderPath = documentsDirectory.appendingPathComponent(dirName)
        return tempFolderPath
    }
}

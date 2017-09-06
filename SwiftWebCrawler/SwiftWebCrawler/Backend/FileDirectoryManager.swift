//
//  FileDirectoryManager.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Cocoa

class FileDirectoryManager: NSObject {
    class func createDirectoryIfNotExists(name: String) {
        let documentsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent(name)
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
    }
    
    class func clearDirectoryWithName(name: String) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let tempFolderPath = documentsDirectory.appendingPathComponent(name)
        do {
            try fileManager.removeItem(atPath: tempFolderPath.path)
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
}

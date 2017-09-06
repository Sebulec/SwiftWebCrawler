//
//  FileViewModel.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation

enum MyError : Error {
    case RuntimeError(String)
}

struct FileViewModel {
    var id: Int
    var filename: String
    var state: String
    
    func getValueForIdentifier(identifier: String) throws -> String {
        switch identifier {
        case "id":
            return String(id)
        case "filename" :
            return filename
        case "state" :
            return state
        default :
            throw MyError.RuntimeError("Not supported cell identifier in file view model")
        }
    }
}

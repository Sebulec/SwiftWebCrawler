//
//  FileFactory.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 06.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import SwiftSoup

class FileFactory {
    class func createFileFromElement(element: Element) -> File {
        let baseUri = element.getBaseUri()
        let url = try! baseUri.appending(element.attr("href"))
        return File(url: url)
    }
}

//
//  CrawlerProtocol.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation

protocol CrawlerProtocol {
    func setUrl(url: String)
    func setSaveDirectory(directory: String)
    func startCrawling(completionHandler:(_ error: Error?) -> Void)
    
}

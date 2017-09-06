//
//  HTMLParser.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 06.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Cocoa
import SwiftSoup

class HTMLParser: NSObject {
    private var htmlContent: String = ""
    private var url: String
    private var lookingFor: DownloadingFileType
    weak var delegate : FileDisplayProtocol?
    
    init(source: String, lookingFor: DownloadingFileType) {
        url = source
        self.lookingFor = lookingFor
    }
    
    func startCrawling() {
        Downloader.getHtmlStringFrom(source: url) { (htmlString) in
            self.htmlContent = htmlString
            self.parseHtmlAndCreateFiles()
        }
    }
    
    private func parseHtmlAndCreateFiles() {
        do {
            let doc: Document = try! SwiftSoup.parse(htmlContent)
            let baseHref = doc.getBaseUri()
            let allLinks : Elements = try! doc.getElementsByTag("a")
            var files : [File] = []
            for element in allLinks {
                let url = try! element.attr("href")
                try! element.setBaseUri(baseHref)
                if let ext =  url.components(separatedBy: ".").last {
                    if ext == lookingFor.rawValue {
                        let file = FileFactory.createFileFromElement(element: element)
                        files.append(file)
                    }
                }
            }
            delegate?.displayFiles(files: files)
        }
    }
}

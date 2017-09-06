//
//  Downloader.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import Alamofire

class Downloader {
    static let destination = getDestination()
    
    class func downloadAndLoadToDocumentDirectory(source: String, progressCallback: @escaping (Double) -> Void) {
        Alamofire.download(source, to: destination)
            .downloadProgress { progress in
                progressCallback(progress.fractionCompleted)
        }
    }
    
    class func getHtmlStringFrom(source: String, completionCallback: @escaping (String) -> Void) {
        Alamofire.request(source).responseString { response in
            if let html = response.result.value {
                completionCallback(html)
            }
        }
    }
    
    class func getDestination() -> DownloadRequest.DownloadFileDestination {
        let destination: DownloadRequest.DownloadFileDestination = { (tempURL: URL, response: HTTPURLResponse) in
            var directoryURL = FileDirectoryManager.getDirectoryPath()
            directoryURL.appendPathComponent(response.suggestedFilename!)
            return (directoryURL, [.removePreviousFile])
        }
        return destination
    }
    
}

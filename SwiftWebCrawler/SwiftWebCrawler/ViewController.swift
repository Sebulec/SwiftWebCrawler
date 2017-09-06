//
//  ViewController.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, FileDisplayProtocol {
    
    @IBOutlet weak var tableView: NSTableView!
    var files: [FileViewModel] = []
    var i = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupParserAndStartCrawling()
    }
    
    func setupParserAndStartCrawling() {
        // for edit
        let parser = HTMLParser(source: "https://videoconverter.wondershare.com/player/mov-player.html", lookingFor: .mov)
        // end for edit
        parser.delegate = self
        parser.startCrawling()
    }
    
    func displayFiles(files: [File]) {
        self.files.removeAll()
        var i = 1
        for file in files {
            let fileViewModel = FileViewModel(id: i, file: file)
            self.files.append(fileViewModel)
            i += 1
        }
        self.tableView.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let item = files[row]
        let identifier = (tableColumn?.identifier)!
        let cell = tableView.make(withIdentifier: (identifier), owner: self) as? NSTableCellView
        cell?.textField?.stringValue = try! item.getValueForIdentifier(identifier: identifier)
        if identifier == "state" {
            Downloader.downloadAndLoadToDocumentDirectory(source: item.url, progressCallback: { (progress) in
                cell?.textField?.stringValue = "\((Int)(progress * 100))%"
            })
        }
        return cell
    }
}


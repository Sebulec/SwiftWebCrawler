//
//  ViewController.swift
//  SwiftWebCrawler
//
//  Created by Sebastian Kotarski on 05.09.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    var files: [FileViewModel] = []
    var i = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTestData()
        tableView.reloadData()
        startTimer()
        FileDirectoryManager.clearDirectoryWithName(name: "WebCrawler")
//        Downloader.downloadAndLoadToDocumentDirectory(source: "https://www.diki.pl/images/diki/diki_logo.svg") { (progress) in
        
//        }
    }
    
    private func setupTestData() {
        let lastValue = i + 3
        while i < lastValue {
            let fileViewModel = FileViewModel(id: i, filename: "File\(i)", state: "\(i*10)%")
            files.append(fileViewModel)
            i += 1
        }
    }
    
    private func setupViews() {

    }
    var gameTimer: Timer?
    private func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    func runTimedCode() {
        setupTestData()
        tableView.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let item = files[row]
        let identifier = (tableColumn?.identifier)!
        let cell = tableView.make(withIdentifier: (identifier), owner: self) as? NSTableCellView
        cell?.textField?.stringValue = try! item.getValueForIdentifier(identifier: identifier)
        return cell
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}


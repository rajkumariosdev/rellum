//
//  AppDelegate.swift
//  RelativeLuminance
//
//  Created by Joseph Blau on 4/25/16.
//  Copyright © 2016 Joe Blau. All rights reserved.
//

import Cocoa
import SnapKit
import RxCocoa
import RxSwift

class AppDelegate: NSObject, NSApplicationDelegate, RelumLabelDelegate {

    private var window = NSWindow()
    private var statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    private let statusBarHeight = NSStatusBar.systemStatusBar().thickness
    private let bag = DisposeBag()
    private let relumLabel = RelumLabel()
    private let statusItemView = NSView()
    private let ddMenu = NSMenu()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        window.collectionBehavior = .CanJoinAllSpaces

        
        ddMenu.addItemWithTitle(NSLocalizedString("quit", comment: "quit"), action: #selector(quit), keyEquivalent: "")
        
        statusItem.menu = ddMenu
        statusItem.highlightMode = false
        statusItem.view = statusItemView

        statusItemView.snp_makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(statusBarHeight)
        }
        
        relumLabel.relumDelegate = self
        statusItemView.addSubview(relumLabel)
        
        relumLabel.snp_makeConstraints { (make) in
            make.top.equalTo(statusItemView.snp_top).offset(2)
            make.left.equalTo(statusItemView.snp_left)
            make.right.equalTo(statusItemView.snp_right)
            make.height.equalTo(statusItemView.snp_height).offset(-4)
        }
        
        let timerSignal = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        timerSignal
            .map { _ -> NSPoint in
                let mouseLocation = NSEvent.mouseLocation()
                let principalScreen = NSScreen.screens()?.first
                return NSMakePoint(mouseLocation.x, principalScreen!.frame.size.height - mouseLocation.y)
            }
            .subscribeNext { (mouseLocation) in
                let imageRect = CGRectMake(mouseLocation.x, mouseLocation.y, 1, 1)
                guard let imageRef = CGWindowListCreateImage(imageRect, .OptionOnScreenOnly, 0, .BestResolution) else {
                    return
                }
                let bitmap = NSBitmapImageRep(CGImage: imageRef)
                guard let pixelColor = bitmap.colorAtX(0, y: 0) else {
                    return
                }
                let isWhite = 0.5 >= (0.2126 * pixelColor.components.red + 0.7152 * pixelColor.components.green + 0.0722 * pixelColor.components.blue)

                self.relumLabel.setWhite(isWhite)
            }
            .addDisposableTo(bag)
    }
    
    // MARK: - RelumLabelDelegate
    
    func showMenu() {
        statusItem.popUpStatusItemMenu(ddMenu)
    }
    
    // MARK: - Selectors
    
    func quit() {
        NSApp.terminate(self)
    }
}

autoreleasepool { () -> () in
    let app = NSApplication.sharedApplication()
    let delegate = AppDelegate()
    app.delegate = delegate
    app.run()
}
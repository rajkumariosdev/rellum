//
//  AppDelegate.swift
//  RelativeLuminance
//
//  Created by Joseph Blau on 4/25/16.
//  Copyright © 2016 Joe Blau. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window = NSWindow()
    

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        window.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
        window.makeKeyAndOrderFront(self)
        
//        let mainMenu = NSApplication.sharedApplication().mainMenu
//        
//        let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
//        let statusItemView = RelativeLuminanceView()
//        
//        statusItem.view = statusItemView
//        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}


//autoreleasepool {
//    let del =   AppDelegate()
//    NSApplication.sharedApplication().delegate  =   del
//    NSApplication.sharedApplication().run()
//}
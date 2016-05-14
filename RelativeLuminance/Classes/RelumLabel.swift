//
//  RelumLabel.swift
//  RelativeLuminance
//
//  Created by Joseph Blau on 5/14/16.
//  Copyright © 2016 Joe Blau. All rights reserved.
//

import Cocoa

protocol RelumLabelDelegate {
    func showMenu()
}

class RelumLabel: NSTextField {

    var relumDelegate: RelumLabelDelegate?
    
    required init() {
        super.init(frame: NSZeroRect)
        
        alignment = .Center
        font = NSFont.menuFontOfSize(16)
        stringValue = "-"
        backgroundColor = NSColor.whiteColor()
        textColor = NSColor.blackColor()
        bordered = false
        selectable = false
        editable = false
        
        wantsLayer = true
        layer?.cornerRadius = 2.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        relumDelegate?.showMenu()
    }
    
    func setWhite(isWhite: Bool) {
        let isDark = NSAppearance.currentAppearance().name.hasPrefix("NSAppearanceNameVibrantDark")
        let whiteBGColor: NSColor? = isDark ? .clearColor() : NSColor(deviceWhite: 0.3, alpha: 1.0)
        
        (backgroundColor, textColor, stringValue) = isWhite ?
            (whiteBGColor, .whiteColor(), NSLocalizedString("white", comment: "white")) :
            (.whiteColor(), .blackColor(), NSLocalizedString("black", comment: "black"))
    }
}

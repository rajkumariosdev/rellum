//
//  NSColor_Components.swift
//  RelativeLuminance
//
//  Created by Joseph Blau on 4/26/16.
//  Copyright © 2016 Joe Blau. All rights reserved.
//

import Cocoa

extension NSColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}
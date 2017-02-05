//
//  customeLine.swift
//  TouchBarPaintSample
//
//  Created by msnr on 2017/01/22.
//  Copyright © 2017年 msnr. All rights reserved.
//

import Cocoa

class CustomeLine : NSObject {
    
    var path : NSBezierPath!
    
    override init() {
  
    }
    
    
    func move(point: NSPoint) {
        path = NSBezierPath()
        
        path.move(to: point)
    }
    
    func add(point: NSPoint) {
        if(path == nil){
            path = NSBezierPath()
            
            path.move(to: point)
            
            return
        }
        
        path.line(to: point)
    }

    
    func draw() {
        if(path == nil){
            return
        }
        
        let appDelegate: AppDelegate = NSApplication.shared().delegate as! AppDelegate
        
        let color = appDelegate.penColor
        let width = CGFloat(appDelegate.penWidth)
        
        color.set()
        path.lineWidth = width
        path.stroke()
        
    }
}

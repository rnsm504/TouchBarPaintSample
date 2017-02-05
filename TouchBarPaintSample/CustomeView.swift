//
//  CustomeView.swift
//  TouchBarPaintSample
//
//  Created by msnr on 2017/01/23.
//  Copyright © 2017年 msnr. All rights reserved.
//

import Cocoa

class CustomeView : NSView {
    
    var line : CustomeLine!
    var lastImage : NSImage!
    
    @IBOutlet weak var imageView: NSImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        line = CustomeLine()

        configure()
    }
    
    func configure() {
        let options:NSTrackingAreaOptions = [
            .mouseEnteredAndExited,
            .mouseMoved,
            .cursorUpdate,
            .activeAlways,
            .enabledDuringMouseDrag
        ]
        let trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
        
    }
    
    
    override func mouseDown(with event: NSEvent) {
        let locationInView = self.convert(event.locationInWindow, from: nil)
        
        line.move(point: locationInView)
        
        drawImage()
    }
    
    override func mouseUp(with event: NSEvent) {
        let locationInView = self.convert(event.locationInWindow, from: nil)
        
        line.add(point: locationInView)
        
        drawImage()
        
        self.lastImage = imageView.image
    }
    
    override func mouseDragged(with event: NSEvent) {
        let locationInView = self.convert(event.locationInWindow, from: nil)
        
        line.add(point: locationInView)
        
        drawImage()
        
    }
    
    override func mouseMoved(with event: NSEvent) {
        //        NSLog("aaa")
    }
    
    
    func drawImage() {
        let size = self.frame.size
        
        let image = NSImage(size: size)
        
        let blub = NSBitmapImageRep(bitmapDataPlanes: nil,
                                    pixelsWide: Int(size.width),
                                    pixelsHigh: Int(size.height),
                                    bitsPerSample: 8,
                                    samplesPerPixel: 3,
                                    hasAlpha: false,
                                    isPlanar: false,
                                    colorSpaceName: NSCalibratedRGBColorSpace,
                                    bytesPerRow: 0, bitsPerPixel: 0)!
        
        let ctx = NSGraphicsContext(bitmapImageRep: blub)
        image.lockFocus()
        
        NSGraphicsContext.saveGraphicsState()
        
        lastImage?.draw(in: self.frame)
        
        line.draw()
        
        NSGraphicsContext.setCurrent(ctx)
        
        NSGraphicsContext.restoreGraphicsState()
        
        image.addRepresentation(blub)
        
        image.unlockFocus()
        
        imageView.image = image
        
    }
    
}

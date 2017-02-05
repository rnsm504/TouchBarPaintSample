//
//  CustomeWindowController.swift
//  TouchBarPaintSample
//
//  Created by msnr on 2017/01/28.
//  Copyright © 2017年 msnr. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarCustomizationIdentifier {
    
    static let touchBar = NSTouchBarCustomizationIdentifier("com.ToolbarSample.touchBar")
}

fileprivate extension NSTouchBarItemIdentifier {
    
    static let colorStyle = NSTouchBarItemIdentifier("com.ToolbarSample.colorStyle")
    static let colorStyleText = NSTouchBarItemIdentifier("com.ToolbarSample.colorStyleText")
    static let colorStyleStroke = NSTouchBarItemIdentifier("com.ToolbarSample.colorStyleStroke")

    static let popover = NSTouchBarItemIdentifier("com.ToolbarSample.TouchBarItem.popover")
    static let popoverSlider = NSTouchBarItemIdentifier("com.ToolbarSample.popoverBar.slider")
    
}


class CustomeWindowController : NSWindowController {
    
    let DefaultPenWidth : Int   = 4
    var currentPenWidth: Int = 0
    
    
    override func windowDidLoad() {
        
        super.windowDidLoad()
      
        self.currentPenWidth = DefaultPenWidth
        
        
        if #available(OSX 10.12.2, *) {
            if ((NSClassFromString("NSTouchBar")) != nil) {
                let fontSizeTouchBarItem = self.touchBar!.item(forIdentifier: .popover) as! NSPopoverTouchBarItem
                let sliderTouchBar = fontSizeTouchBarItem.popoverTouchBar
                let sliderTouchBarItem = sliderTouchBar.item(forIdentifier: .popoverSlider) as! NSSliderTouchBarItem
                let slider = sliderTouchBarItem.slider
                
                // Make the font size slider a bit narrowed, about 250 pixels.
                let views = ["slider" : slider]
                let theConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[slider(250)]", options: NSLayoutFormatOptions(), metrics: nil, views:views)
                NSLayoutConstraint.activate(theConstraints)
                
                // Set the font size for the slider item to the same value as the stepper.
                slider.integerValue = Int(DefaultPenWidth)
            }
        }
    }
    
    // MARK: - NSTouchBar
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .touchBar
        touchBar.defaultItemIdentifiers = [.colorStyle, .colorStyleText, .colorStyleStroke, .popover, .otherItemsProxy]
        touchBar.customizationAllowedItemIdentifiers = [.colorStyle, .colorStyleText, .colorStyleStroke, .popover]
        
        return touchBar
    }

    
    @available(OSX 10.12.2, *)
    func changeColorWell(sender : NSColorPickerTouchBarItem) -> Void {
        let color = NSColor(calibratedHue: sender.color.hueComponent
            , saturation: sender.color.saturationComponent
            , brightness: sender.color.brightnessComponent
            , alpha: sender.color.alphaComponent)
        
        let appDelegate: AppDelegate = NSApplication.shared().delegate as! AppDelegate
        
        appDelegate.penColor = color
    }
    
    
    @available(OSX 10.12.2, *)
    func changeFontSizeBySlider(_ sender: NSSlider) -> Void {
        let width = CGFloat(sender.floatValue)
        
        let appDelegate: AppDelegate = NSApplication.shared().delegate as! AppDelegate
        
        appDelegate.penWidth = Int(width)
    }

}


extension CustomeWindowController: NSTouchBarDelegate {
    
    @available(OSX 10.12.2, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
            
        case NSTouchBarItemIdentifier.colorStyle:
            
            let colorStylePicker = NSColorPickerTouchBarItem.colorPicker(withIdentifier: identifier)
            colorStylePicker.customizationLabel = "colorStylePicker"
            colorStylePicker.action = #selector(changeColorWell)
            
            return colorStylePicker
        
        case NSTouchBarItemIdentifier.colorStyleText:
            
            let colorStylePicker = NSColorPickerTouchBarItem.textColorPicker(withIdentifier: identifier)
            colorStylePicker.customizationLabel = "colorStyleText"
            colorStylePicker.action = #selector(changeColorWell)
            
            return colorStylePicker

        case NSTouchBarItemIdentifier.colorStyleStroke:
            
            let colorStylePicker = NSColorPickerTouchBarItem.strokeColorPicker(withIdentifier: identifier)
            colorStylePicker.customizationLabel = "colorStyleStroke"
            colorStylePicker.action = #selector(changeColorWell)
            
            return colorStylePicker
            
        case NSTouchBarItemIdentifier.popover:
            
            let popoverItem = NSPopoverTouchBarItem(identifier: identifier)
            popoverItem.customizationLabel = "Pen Width"
            popoverItem.collapsedRepresentationLabel = "Pen Width"
            
            let secondaryTouchBar = NSTouchBar()
            secondaryTouchBar.delegate = self
            secondaryTouchBar.defaultItemIdentifiers = [.popoverSlider];
            
            // We can setup a different NSTouchBar instance for popoverTouchBar and pressAndHoldTouchBar property
            // Here we just use the same instance.
            //
            popoverItem.pressAndHoldTouchBar = secondaryTouchBar
            popoverItem.popoverTouchBar = secondaryTouchBar
            
            return popoverItem
            

        case NSTouchBarItemIdentifier.popoverSlider:
            
            let sliderItem = NSSliderTouchBarItem(identifier: identifier)
            sliderItem.label = "Width"
            sliderItem.customizationLabel = "pen Width"
            
            let slider = sliderItem.slider
            slider.minValue = 2.0
            slider.maxValue = 20.0
            slider.target = self
            slider.action = #selector(changeFontSizeBySlider)
            
            // Set the font size for the slider item to the same value as the stepper.
            slider.integerValue = Int(DefaultPenWidth)
            
            slider.bind(NSValueBinding, to: self, withKeyPath: "currentPenWidth", options: nil)
            
            return sliderItem
            
        default: return nil
        }
    }
}

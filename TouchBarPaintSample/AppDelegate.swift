//
//  AppDelegate.swift
//  TouchBarPaintSample
//
//  Created by msnr on 2017/01/22.
//  Copyright © 2017年 msnr. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var penColor  = NSColor.black
    var penWidth : Int  = 4

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
//        let storyboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
//     
//        let wc = storyboard.instantiateInitialController() as! NSWindowController
//        wc.window?.acceptsMouseMovedEvents = true
//        
        
//        let windowController = storyboard.instantiateController(withIdentifier: "MyWindowController") as! NSWindowController
//        
//        
//        windowController.window?.acceptsMouseMovedEvents = true
        
        // Here we just opt-in for allowing our instance of the NSTouchBar class to be customized throughout the app.
        if #available(OSX 10.12.2, *) {
            if ((NSClassFromString("NSTouchBar")) != nil) {
                NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
            }
        }
        
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


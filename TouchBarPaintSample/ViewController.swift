//
//  ViewController.swift
//  TouchBarPaintSample
//
//  Created by msnr on 2017/01/22.
//  Copyright © 2017年 msnr. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
        
  
    override func viewDidLoad() {
        super.viewDidLoad()

     }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: - NSTextViewDelegate
    
    func textView(_ textView: NSTextView, shouldUpdateTouchBarItemIdentifiers identifiers: [NSTouchBarItemIdentifier]) -> [NSTouchBarItemIdentifier] {
        
        return []   // We want to show only our NSTouchBarItem instances.
    }
    
    
}


//
//  ViewController.swift
//  AssetFixture
//
//  Created by Julien Chaumond on 01/04/2015.
//  Copyright (c) 2015 Julien Chaumond. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let buttons = ["UIImagePickerController", "Fixture", "Fixture 2"]
    var f: AssetFixture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (i, b) in enumerate(buttons) {
            let button = UIButton.buttonWithType(.System) as UIButton
            button.frame = CGRectMake(0, 240 + CGFloat(i)*40, self.view.bounds.width, 30)
            button.setTitle(b, forState: .Normal)
            button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
        }
        
        f = AssetFixture()
        f!.loadImages()
    }
    
    
    func buttonPressed(button: UIButton) {
        if button.currentTitle == "UIImagePickerController" {
            let imagePicker = UIImagePickerController()
            self.presentViewController(imagePicker, animated: true) { () -> Void in }
            return
        }
        if button.currentTitle == "Fixture" {
            f!.loadSavedPhotos(iterations: 5)
            return
        }
        if button.currentTitle == "Fixture 2" {
            f!.ensureAlbum({ (group, error) -> Void in
                if (error != nil) {
                    println(error)
                    return
                }
                if let group = group {
                    println(group)
                    let loader = self.f!.loadAlbum(iterations: 2)
                    return loader(group)
                }
            })
            return
        }
    }
    
}


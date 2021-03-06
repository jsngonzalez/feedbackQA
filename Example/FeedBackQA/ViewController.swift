//
//  ViewController.swift
//  FeedBackQA
//
//  Created by Jeisson Gonzalez on 03/27/2020.
//  Copyright (c) 2020 Jeisson Gonzalez. All rights reserved.
//

import UIKit
import FeedBackQA

class ViewController: UIViewController {
    
    @IBOutlet weak var viewExample: UIView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = FeedBack(appid: "asdf1234")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        #if swift(<4.2)
            let name = NSNotification.Name.UIApplicationUserDidTakeScreenshot
        #else
            let name = UIApplication.userDidTakeScreenshotNotification
        #endif
        
        NotificationCenter.default.post(name: name, object: nil)
    }

    @IBAction func hideShow(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


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
        
        FeedBack(token: "hola como vas")
    }

    @IBAction func hideShow(_ sender: Any) {
        if btn.tag == 0 {
            btn.tag = 1
            viewExample.fadeOut()
        }else{
            btn.tag = 0
            viewExample.fadeIn()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


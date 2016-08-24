//
//  ViewController.swift
//  Utilities
//
//  Created by Daniel Garcia on 6/29/16.
//  Copyright © 2016 Daniel Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var comboBox1: UIComboBox!
    @IBOutlet weak var comboBox2: UIComboBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comboBox1.name = "CB1"
        comboBox2.name = "CB2"
        comboBox1.items = ["Item 1","Item 2","Item 3"]
        comboBox2.items = ["Item 4","Item 5","Item 6"]
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


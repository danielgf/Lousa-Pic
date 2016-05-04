//
//  LookViewController.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/3/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit

class LookViewController: UIViewController {
    
    //Variables for our code
    
    
    //Outputs from our screen
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Action for our buttons in the screen
    
    @IBAction func edit(sender: UIBarButtonItem) {
    }
    
    //Functions
    
}

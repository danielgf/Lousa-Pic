//
//  EditViewControllwe.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/3/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit

class EditViewControllwe: UIViewController {
    
    //Variables for our code

    //Outputs from our screen
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
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
    @IBAction func save(sender: UIBarButtonItem) {
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
    }
    
    @IBAction func libraryPhoto(sender: UIBarButtonItem) {
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
    }
    
    //Functions
}

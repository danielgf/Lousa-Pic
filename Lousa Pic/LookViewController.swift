//
//  LookViewController.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/4/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit

class LookViewController: UIViewController {
    
    var item :LousaPic? = nil

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var materia: UILabel!
    @IBOutlet weak var obs: UITextView!
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        materia.text = item?.materia
        obs.text = item?.observacoes
        date.text = item?.date!
        myImageView.image = UIImage(data: (item?.image)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "edit" {
            navigationController?.title = "Editing"
            
            let itemController:AddViewController = segue.destinationViewController as! AddViewController
            itemController.item = item
            
        }
    }

}

//
//  EditViewController.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/4/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController,NSFetchedResultsControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //Variables code
    var item :LousaPicInfo? = nil
    
    //Create this to reference our dataBase
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateField: UITextField!

    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.text = item?.materia
        textView.text = item?.observacoes
        dateField.text = item?.date
        imageView.image = UIImage(data: (item?.image)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save(sender: UIBarButtonItem) {
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
    }
    
    @IBAction func libraryPhoto(sender: UIBarButtonItem) {
    }
    
    @IBAction func cameraPhoto(sender: UIBarButtonItem) {
    }
    
    func editItem(){
        item?.materia = textField.text
        item?.observacoes = textView.text
        item?.date = dateField.text
        item?.image = UIImagePNGRepresentation(imageView.image!)
        
        do{
            try moc.save()
        }catch{
            print("Failed save.")
        }
    }
    
}

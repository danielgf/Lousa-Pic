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
    var item :LousaPic? = nil
    
    //Create this to reference our dataBase
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Outlet
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.text = item?.materia
        textView.text = item?.observacoes
        myImageView.image = UIImage(data: (item?.image)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save(sender: UIBarButtonItem) {
        editItem()
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissVC()
    }
    
    @IBAction func libraryPhoto(sender: UIBarButtonItem) {
    }
    
    @IBAction func cameraPhoto(sender: UIBarButtonItem) {
        
    }
    
    func dismissVC(){
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func editItem(){
        item?.materia = textField.text
        item?.observacoes = textView.text
        item?.image = UIImagePNGRepresentation(myImageView.image!)
        
        do{
            try moc.save()
        }catch{
            print("Failed save.")
        }
    }
    
}

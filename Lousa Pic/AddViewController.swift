//
//  AddViewController.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/3/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,NSFetchedResultsControllerDelegate {
    
    //Variables for our code
    //Create this to reference our dataBase
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var item: LousaPicInfo? = nil
    
    //Image Picker for our camera
    let imagePicker:UIImagePickerController = UIImagePickerController()
    
    //Outputs from our screen
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Delegate our imagePicker and textViewr to hisself
        imagePicker.delegate = self
        textView.delegate = self
        
        //Checkig if the textView have something inside
        if (textView.text == "") {
            textViewDidEndEditing(textView)
        }
        
        //Dimiss the keyboard
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(AddViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapDismiss)
        
        //Delegate our imagePicker to hisself
        imagePicker.delegate = self
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Action for our buttons in the screen
    @IBAction func save(sender: UIBarButtonItem) {
        
        createItem()
        dismissVC()

//        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(AddViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        //We take the text who has into textField and put inside core data
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissVC()
    }
    
    @IBAction func clean(sender: UIBarButtonItem) {
        imageView.image = UIImage(named: "retouche-photo")
        textView.text = nil
        textField.text = ""
        if (textView.text == "") {
            textViewDidEndEditing(textView)
        }
        self.postAlert("Delete", message: "You delete all the content. Now you have to start over.")
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        takePicture()
    }
    
    @IBAction func chooseFromLibrary(sender: UIBarButtonItem) {
        pickPhotoFromLibrary()
    }
    
    
    //Functions
    
    //Func to dimiss the keyboard
    func dismissKeyboard(){
        textView.resignFirstResponder()
        textField.resignFirstResponder()
    }
    
    //Func to put an Place Holder inside our textViwer
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Observações"
            textView.textColor = UIColor.lightGrayColor()
        }
        textView.resignFirstResponder()
        
    }
    
    //Func to remove the Place Holder and start to write
    func textViewDidBeginEditing(textView: UITextView){
        if (textView.text == "Observações"){
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    
    //Func to dismiss the keyboard when type the return on the keyboard
    func textViewShouldReturn(textView: UITextView!) -> Bool {
        self.view.endEditing(true)
        self.view.endEditing(true)
        return true;
    }
    
    //Alert
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func dismissVC(){
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func createItem(){
        
        let entityDescription = NSEntityDescription.entityForName("LuosaPicInfo", inManagedObjectContext: moc)
        
        let item = LousaPicInfo(entity: entityDescription!, insertIntoManagedObjectContext: moc)
        
        item.materia = textField.text
        item.observacoes = textView.text
        item.date = dateField.text
        item.image = UIImagePNGRepresentation(imageView.image!)
        
        do{
            try moc.save()
        }catch{
            print("Failed save.")
            return
        }
        
    }
    
    
    //Function save image into Library
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
}

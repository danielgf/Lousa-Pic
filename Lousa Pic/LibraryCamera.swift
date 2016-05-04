//
//  LibraryCameral.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/3/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit

extension AddViewController{
    
    func pickPhotoFromLibrary() {
        
        //Checking is the the Library is avaliable
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            //Checking is the Library is diferent then nil
            imagePicker.delegate = self
            //Where you will take photo
            imagePicker.sourceType = .PhotoLibrary
            //Animation Controller
            presentViewController(imagePicker, animated: true, completion: nil)
            //Library is inavable
        }else{
            //Alert for you
            self.postAlert("Library inaccessable", message: "Application can not access the Library.")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        imageView.contentMode = .ScaleToFill
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

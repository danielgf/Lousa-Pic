//
//  CameraReal.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/3/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit

extension AddViewController{
    
    
    func takePicture(){
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: nil)
            }else{
                self.postAlert("Real camera does not exist", message: "Application can not access the camera.")
            }
        }else{
            self.postAlert("Camera inaccessible", message:"Application can not access the camera.")
        }
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            print("Got an image")
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imageView.contentMode = .ScaleToFill
                imageView.image = pickedImage
            }
            
            //Dismiss View Controller
            imagePicker.dismissViewControllerAnimated(true, completion: {
                self.postAlert("Saved Image", message:"Image saved with Success")
            })
            
        }
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController){
            print("User cancel image")
            dismissViewControllerAnimated(true, completion: {
                self.postAlert("Canceled", message:"You canceled, the program will not show any picture. If you still want to take a picture you have to click in the camera button again.")
            })
        }
        
    }
}

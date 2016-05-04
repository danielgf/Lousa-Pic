//
//  ViewController.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/3/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit
import CoreData

extension AddViewController{
    
    
    func saveIntoCoreData(){
        
        //Create an variable to help ous to put informations on the data base
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Info", inManagedObjectContext: managedObjectContext) as! Info
        newItem.materia = textField.text
        newItem.observacoes = textView.text
        
        //Create a new fetch request using the Ingo entity
        let fetchRequest = NSFetchRequest(entityName:"Info")
        
        //Execute the fetch request, and cast the results to an array of Info objects
        if let fetchResults = (try? managedObjectContext.executeFetchRequest(fetchRequest)) as? [Info]{
            
            // Create an Alert, and set it's message to whatever the itemText is
            let alert = UIAlertController(title: fetchResults[0].materia, message: fetchResults[0].observacoes, preferredStyle: .Alert)
            
            //Diplay the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
}

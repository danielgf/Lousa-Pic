//
//  MyTableViewController.swift
//  Lousa Pic
//
//  Created by Daniel Griso Filho on 5/4/16.
//  Copyright © 2016 Daniel Griso Filho. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    //Variables for uor code
    
    //Create this to reference our dataBase
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Create this to stoge our results
    var fetchResultsController : NSFetchedResultsController = NSFetchedResultsController()
    
    
    //Functions 
    
    //Func to request infos from our dataBase
    func fetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "LuosaPicInfo")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    //Get the results
    func getFRC() -> NSFetchedResultsController {
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultsController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultsController = getFRC()
        fetchResultsController.delegate = self
        
        do{
            try fetchResultsController.performFetch()
        }catch{
            print("Falied to perform initial fetch.")
            return
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchResultsController = getFRC()
        fetchResultsController.delegate = self
        
        do{
            try fetchResultsController.performFetch()
        }catch{
            print("Falied to perform initial fetch.")
            return
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        let numberOfSections = fetchResultsController.sections?.count
        
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let numberOfRowsInSection = fetchResultsController.sections?[section].numberOfObjects
        
        return numberOfRowsInSection!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        let item = fetchResultsController.objectAtIndexPath(indexPath) as! LousaPicInfo
        cell.textLabel?.text = item.materia
        let date = item.date
        let obs = item.observacoes
        cell.detailTextLabel?.text = "Observações: \(obs!) Date: \(date!)"
        cell.imageView?.image = UIImage(data: (item.image)!)

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject: NSManagedObject = fetchResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        moc.deleteObject(managedObject)
        
        do{
            try moc.save()
        }catch{
            print("Failed to save.")
            return
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "editing" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController:EditViewController = segue.destinationViewController as! EditViewController
            let item : LousaPicInfo = fetchResultsController.objectAtIndexPath(indexPath!) as! LousaPicInfo
            
            itemController.item = item
            
        }
    }

}

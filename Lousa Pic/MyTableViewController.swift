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
    var resultSearchController = UISearchController()
    
    //Create this to reference our dataBase
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Create this to stoge our results
    var fetchResultsController : NSFetchedResultsController = NSFetchedResultsController()
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    //Functions
    
    
    //Func to request infos from our dataBase
    func fetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "LousaPic")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    //Get the results
    func getFRC() -> NSFetchedResultsController {
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultsController
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        
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
        
        self.tableView.reloadData()
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
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyTableViewCell
        
        // Configure the cell...
        
        let item = fetchResultsController.objectAtIndexPath(indexPath) as! LousaPic
        cell.materiaTextLabel.text = item.materia
        cell.dateTextLabel.text = "\(item.date!)"
        cell.obsTextLabel.text = item.observacoes
        cell.myImageView.image = UIImage(data: (item.image)!)

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
        
        let managedObject: NSManagedObject = self.fetchResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        
        if editingStyle == .Delete {
            
            moc.deleteObject(managedObject)
            do{
                try moc.save()
                viewDidLoad()
            }catch{
                print("Failed to save.")
                return
            }
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
        
        if segue.identifier == "look" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController:LookViewController = segue.destinationViewController as! LookViewController
            let item : LousaPic = fetchResultsController.objectAtIndexPath(indexPath!) as! LousaPic
            itemController.item = item
            
        }
    }

}

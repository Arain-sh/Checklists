//
//  AllListsTableViewController.swift
//  Checklists
//
//  Created by Arain on 15/7/1.
//  Copyright (c) 2015年 Arain. All rights reserved.
//

import UIKit

class AllListsTableViewController: UITableViewController, ListDetailTableViewControllerDelegate {
    //var lists: [Checklist]
    var dataModel: DataModel!
    
//    required init(coder aDecoder: NSCoder) {
//        dataModel.lists = [Checklist]()
//        super.init(coder: aDecoder)
////        loadChecklists()
////        println("Documents folder is \(documentsDirectory())")
////        println("Data file path is \(dataFilePath())")
////        for list in lists {
////            let item = ChecklistItem()
////            item.text = "Item for \(list.name)"
////            list.items.append(item)
////        }
//    }
//        func documentsDirectory() -> String {
//            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
//            return paths[0]
//        }
//    
//        func dataFilePath() -> String {
//            return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
//        }
//    
//        func saveChecklists() {
//            let data = NSMutableData()
//            let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//            archiver.encodeObject(lists, forKey: "Checklists")
//            archiver.finishEncoding()
//            data.writeToFile(dataFilePath(), atomically: true)
//        }
//    
//        func loadChecklists() {
//            let path = dataFilePath()
//            if NSFileManager.defaultManager().fileExistsAtPath(path) {
//                if let data = NSData(contentsOfFile: path) {
//                    let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                    lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
//                    unarchiver.finishDecoding()
//                }
//            }
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataModel.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        let Checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = Checklist.name
        cell.accessoryType = .DetailDisclosureButton
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let checklist = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    func listDetailViewControllerDidCancel(controller: ListDetailTableViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailTableViewController, didFinishAddingChecklist checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    func listDetailViewController(Controller: ListDetailTableViewController, didFinishEditingChecklist checklist: Checklist) {
        if let index = find(dataModel.lists, checklist) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! ListDetailTableViewController
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        presentViewController(navigationController, animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! ChecklistTableViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailTableViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }

}

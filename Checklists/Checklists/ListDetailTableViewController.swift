//
//  ListDetailTableViewController.swift
//  Checklists
//
//  Created by Arain on 15/7/1.
//  Copyright (c) 2015年 Arain. All rights reserved.
//

import UIKit

protocol ListDetailTableViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailTableViewController)
    func listDetailViewController(controller: ListDetailTableViewController, didFinishAddingChecklist checklist: Checklist)
    func listDetailViewController(controller: ListDetailTableViewController, didFinishEditingChecklist checklist: Checklist)
}

class ListDetailTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailTableViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text
            delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
        } else {
            let checklist = Checklist(name: textField.text)
            delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

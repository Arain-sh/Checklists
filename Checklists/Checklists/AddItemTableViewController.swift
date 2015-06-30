//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Arain on 15/6/23.
//  Copyright (c) 2015年 Arain. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemTableViewControllerDidCancel(controller: AddItemTableViewController)
    func addItemTableViewController(controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem)
    func addItemTableViewController(controller: AddItemTableViewController, didFinishEditingItem item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: AddItemTableViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    @IBAction func cancel() {
        delegate?.addItemTableViewControllerDidCancel(self)
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text
            delegate?.addItemTableViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text
            item.checked = false
            delegate?.addItemTableViewController(self, didFinishAddingItem: item)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
}

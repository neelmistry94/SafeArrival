//
//  ContactGroupTableViewController.swift
//  SafeArrival
//
//  Created by Michelle Jeffries on 12/7/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import UIKit

var contactGroups = [ContactGroup]()

class ContactGroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addTapped:")
        // 2
        var rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editTapped:")
        // 3
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem,rightSearchBarButtonItem], animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped(sender: UIButton) {
        performSegueWithIdentifier("Add Contacts Page", sender: self)
    }
    func editTapped(sender: UIButton) {
        self.editing = !self.editing
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return contactGroups.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactGroupCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactGroupTableViewCell

        let g = contactGroups[indexPath.row]
        let stringRepresentation = ", ".join(g.contacts)
        
        cell.contactGrpName.text = g.name
        cell.contactGrpPreview.text = stringRepresentation
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = contactGroups[fromIndexPath.row]
        contactGroups.removeAtIndex(fromIndexPath.row)
        contactGroups.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

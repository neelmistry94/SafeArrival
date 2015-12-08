//
//  AddContactTableViewController.swift
//  SafeArrival
//
//  Created by Michelle Jeffries on 12/7/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import UIKit

var contacts = [String]()

class AddContactTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var contactList: UITableView!{
        didSet{
            contactList.delegate = self
        }
    }
    
    @IBOutlet weak var groupName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(contacts.count);
        
        println(tableView(contactList, numberOfRowsInSection: 1))
        contactList.delegate = self
        
        self.contactList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func save(sender: AnyObject) {
        var disableMyButton = sender as? UIButton
        disableMyButton!.enabled = false
        disableMyButton?.hidden = true
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactTableViewCell

        let nm = contacts[indexPath.row]
        
        cell.name.text = nm

        return cell
    }
}

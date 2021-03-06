//
//  AddMessageViewController.swift
//  SafeArrival
//
//  Created by Michelle Jeffries on 12/7/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import UIKit

class AddMessageViewController: UIViewController {

    // MARK: Text Elements
    @IBOutlet weak var newMsgName: UITextField!
    @IBOutlet weak var newMsgMsg: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        let m = Message(name: newMsgName.text!, contents: newMsgMsg.text!)!

        messages += [m]
        
        var disableMyButton = sender as? UIButton
        disableMyButton!.enabled = false
        disableMyButton?.hidden = true
    }
}

//
//  SummaryViewController.swift
//  SafeArrival
//
//  Created by Michelle Jeffries on 12/7/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var curDest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        curDest.text = currentDestination as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EnRoute(sender: AnyObject) {
        var titleLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.navigationController!.navigationBar.frame.size.width, self.navigationController!.navigationBar.frame.size.height))
        titleLabel.text = "En Route To..."
        titleLabel.font = UIFont(name: "Helvetica", size: 25.0)
        titleLabel.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = titleLabel
        
        var disableMyButton = sender as? UIButton
        disableMyButton!.enabled = false
        disableMyButton?.hidden = true
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: Selector("someSelector"), userInfo: nil, repeats: false)
    }
    
    func someSelector(){
        let alert = UIAlertController(title: "Destination Reached", message: "Message was sent!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {alertAction in self.performSegueWithIdentifier("Return Home", sender: self)}))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

//
//  ContactTableViewCell.swift
//  SafeArrival
//
//  Created by Michelle Jeffries on 12/7/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

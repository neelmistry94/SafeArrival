//
//  MessageTableViewCell.swift
//  SafeArrival
//
//  Created by Alex Jeffries on 12/6/15.
//  Copyright (c) 2015 Alex Jeffries. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var messagePreview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

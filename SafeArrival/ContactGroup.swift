//
//  ContactGroup.swift
//  SafeArrival
//
//  Created by Michelle Jeffries on 12/7/15.
//  Copyright (c) 2015 Neel Mistry. All rights reserved.
//

import Foundation

class ContactGroup {
    
    var name: String
    var contacts: [String] = []
    
    init?(name: String, contents: [String]) {
        self.name = name
        self.contacts = contents
        
        if (name.isEmpty || contents.isEmpty){
            return nil
        }
    }
}
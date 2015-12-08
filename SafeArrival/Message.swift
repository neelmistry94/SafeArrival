//
//  Message.swift
//  SafeArrival
//
//  Created by Alex Jeffries on 12/7/15.
//  Copyright (c) 2015 Alex Jeffries. All rights reserved.
//

import Foundation

class Message{
    
    var name: String
    var contents: String
    
    init?(name: String, contents: String) {
        self.name = name
        self.contents = contents
        
        if (name.isEmpty || contents.isEmpty){
            return nil
        }
    }
}
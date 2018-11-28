//
//  Users.swift
//  SaliteDb
//
//  Created by Yabaze T on 27/11/18.
//  Copyright © 2018 Yabaze T. All rights reserved.
//

import Foundation

class Users: NSObject {
    var firstName:String
    var LastName:String
    var email:String
    var password:String

    init(firstName:String,LastName:String,email:String,password:String) {
            self.firstName=firstName
            self.LastName=LastName
            self.email=email
            self.password=password
        }
    
}

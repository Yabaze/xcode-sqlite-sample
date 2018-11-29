//
//  Users.swift
//  SaliteDb
//
//  Created by Yabaze T on 27/11/18.
//  Copyright © 2018 Yabaze T. All rights reserved.
//

import Foundation

class Users {
    var firstName:NSString!
    var LastName:NSString!
    var email:NSString!
    var password:NSString!
    

  init(firstName:String,LastName:String,email:String,password:String) {
            self.firstName=firstName as NSString
            self.LastName=LastName as NSString
            self.email=email as NSString
            self.password=password as NSString
        }
    
}

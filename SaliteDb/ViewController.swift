//
//  ViewController.swift
//  SaliteDb
//
//  Created by Yabaze T on 27/11/18.
//  Copyright © 2018 Yabaze T. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db=DatabaseHelper.init()
        
        let user:Users=Users.init(firstName: "abc", LastName: "xyz", email: "abc@xy.com", password: "1234")
        db.registerUser(user: user)
        db.retrieveUserData()

    }
}


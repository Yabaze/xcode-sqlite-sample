//
//  DatabaseHelper.swift
//  SaliteDb
//
//  Created by Yabaze T on 27/11/18.
//  Copyright © 2018 Yabaze T. All rights reserved.
//

import Foundation
import SQLite3

class DatabaseHelper{
    var db: OpaquePointer?
    let createUserTable = "CREATE TABLE IF NOT EXISTS Users(id INTEGER PRIMARY KEY AUTOINCREMENT,firstName TEXT,LastName TEXT,email TEXT NOT NULL UNIQUE,password TEXT);"
    
    init() {
        db=createDatabase()
        createTable()
    }
    
    
    public func createDatabase()->OpaquePointer{
       let fileURL=try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("sample.sqlite")
        print(fileURL)
        let result=sqlite3_open(fileURL.path, &db)
        if result == SQLITE_OK {
            print("Successfully connected to database. ")
            return db!
        } else {
            print("Unable to open database. Verify that you created the directory described in the Getting Started section.")
            return nil!
        }
    }
    
    public func createTable() {
        // 1
        var createTableStatement: OpaquePointer?
        // 2
        let userTable=sqlite3_prepare_v2(db, createUserTable, -1, &createTableStatement, nil)
        if  userTable == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("User table created.")
            } else {
                print("User table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        // 4
        sqlite3_finalize(createTableStatement)
    }  
    
    public func registerUser(user:Users){
        var insertStatement: OpaquePointer?
        
        let insertStatementString = "INSERT INTO Users (firstName,LastName,email,password) VALUES (?,?,?,?);"
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, user.firstName.utf8String,-1,nil)
            sqlite3_bind_text(insertStatement, 2, user.LastName.utf8String,-1,nil)
            sqlite3_bind_text(insertStatement, 3, user.email.utf8String,-1,nil)
            sqlite3_bind_text(insertStatement, 4, user.password.utf8String,-1,nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting User: \(errmsg)")
                print("Could not insert row.")
                return
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    let queryStatementString = "SELECT * FROM Users;"
    
    func retrieveUserData() {
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(queryStatement, 0)
                
                let firstName = String(cString: sqlite3_column_text(queryStatement, 1)!)
                
                let LastName = String(cString: sqlite3_column_text(queryStatement, 2)!)
                
                let email=String(cString: sqlite3_column_text(queryStatement, 3)!)
                
                let password = String(cString: sqlite3_column_text(queryStatement, 4)!)

                
                print("\(id)| \(firstName) | \(LastName) | \(email) | \(password) ")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
    }
}

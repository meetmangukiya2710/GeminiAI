//
//  DBHelper.swift
//  GeminiAI
//
//  Created by R95 on 12/06/24.
//

import Foundation
import SQLite3
import UIKit

struct UserData {
    var email: String
    var password: String
}

class DBHelper {
    public static var userArray = [UserData]()
    static var file : OpaquePointer?
    
    static func creatFile(){
        var a = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        a.appendPathComponent("GeminiAI.db")
        sqlite3_open(a.path, &file)
        print(a.path)
        creatTable()
    }
    
    static func creatTable(){
        let q = "Create Table if not exists User (email text, password text)"
        var table: OpaquePointer?
        sqlite3_prepare(file, q, -1, &table, nil)
        sqlite3_step(table)
    }
    
    static func addData(email: String, password: String){
        let q = "insert into user values ('\(email)','\(password)')"
        var add: OpaquePointer?
        sqlite3_prepare(file, q, -1, &add, nil)
        sqlite3_step(add)
    }
    
    static func getData() {
        var emailUser = ""
        var passwordUser = ""
        let q = "SELECT * FROM User"
        var read: OpaquePointer?
        sqlite3_prepare(file, q, -1, &read, nil)
        while sqlite3_step(read) == SQLITE_ROW {
            if let email = sqlite3_column_text(read, 0),
               let password = sqlite3_column_text(read, 1) {
                let userEmail = String(cString: email)
                let userPassword = String(cString: password)
                let userData = UserData(email: userEmail, password: userPassword)
                userArray.append(userData)
                print("Email: \(userEmail), Password: \(userPassword)")
            }
        }
    }

}

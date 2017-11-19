//
//  Account.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import Foundation
import Firebase

struct Account {
    
    let key: String
    let accountName: String
    let balance: Double
    let ref: DatabaseReference?
    
    init(accountName: String, balance: Double, key: String = "") {
        self.key = key
        self.accountName = accountName
        self.balance = balance
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        accountName = snapshotValue["accountName"] as! String
        balance = snapshotValue["balance"] as! Double
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "accountName": accountName,
            "balance": balance
        ]
    }
}

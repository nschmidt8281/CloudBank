//
//  Transaction.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import Foundation
import Firebase

struct Transaction {
    
    let key: String
    let amount: Double
    let credit: Bool
    let vendor: String
    let date: String
    let ref: DatabaseReference?
    
    init(amount: Double, credit: Bool, vendor: String, date: String, key: String = "") {
        self.key = key
        self.amount = amount
        self.credit = credit
        self.vendor = vendor
        self.date = date
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        amount = snapshotValue["amount"] as! Double
        credit = snapshotValue["credit"] as! Bool
        vendor = snapshotValue["vendor"] as! String
        date = snapshotValue["date"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "amount": amount,
            "credit": credit,
            "vendor": vendor,
            "date": date
        ]
    }
}

//
//  TransactionViewController.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit
import Firebase

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var transactions: [Transaction] = []
    var rTransactions: [Transaction] = []
    var user = Auth.auth().currentUser!
    var selectedAccount = String()
    
    // MARK: Constants
    let ref = Database.database()
    let dateFormatter = DateFormatter()
    let signIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn") as! AuthorizationViewController
    
    // MARK: Buttons
    @IBAction func btnSignOut_Touch(_ sender: UIBarButtonItem) {

        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        let signIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn") as! AuthorizationViewController
        self.present(signIn, animated: true, completion: nil)
    }
    
    @IBAction func btnBack_Touch(_ sender: Any?) {
        performSegue(withIdentifier: "TransactionBack", sender: self)
    }
    
    @IBOutlet weak var tableviewTransactions: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.reference(withPath: "transactions/\(user.uid)/\(selectedAccount)").observe(.value, with: { snapshot in
        var newTransactions: [Transaction] = []
            
            for transaction in snapshot.children {
                let transaction = Transaction(snapshot: transaction as! DataSnapshot)
                newTransactions.append(transaction)
            }
            
            self.transactions = newTransactions
            self.rTransactions = newTransactions
            
            for i in 1...self.transactions.count {
                self.rTransactions[i - 1] = self.transactions[self.transactions.count - i]
            }

            self.tableviewTransactions.reloadData()
        })
        
        tableviewTransactions.allowsSelection = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath) as! TransactionCell
        
        let transaction = rTransactions[indexPath.row]
        cell.lblTransactionDate?.text = transaction.date
        cell.lblVendor?.text = transaction.vendor
        cell.lblTransactionAmount?.text = String(format: "$%.02f", transaction.amount)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



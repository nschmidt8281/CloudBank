//
//  AccountViewController.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var accounts: [Account] = []
    var user = Auth.auth().currentUser!
    var selectedAccount: String?
    
    // MARK: Constants
    let ref = Database.database()
    
    // MARK: Outlets
    @IBOutlet weak var tableviewAccounts: UITableView!
    @IBOutlet weak var actSpinner: UIActivityIndicatorView!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.reference(withPath: "accounts/\(user.uid)").queryOrdered(byChild: "accountName").observe(.value, with: { snapshot in
            var newAccounts: [Account] = []
            
            for account in snapshot.children {
                let account = Account(snapshot: account as! DataSnapshot)
                newAccounts.append(account)
            }
            
            self.accounts = newAccounts
            self.tableviewAccounts.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "account", for: indexPath) as! AccountCell
        
        let account = accounts[indexPath.row]
        cell.lblAccountName?.text = account.accountName
        cell.lblBalance?.text = String(format: "$%.02f", account.balance)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAccount = self.accounts[indexPath.row].accountName
        
        performSegue(withIdentifier: "AccountSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AccountSelected" {
            let transactionsVC = segue.destination as! TransactionViewController
            transactionsVC.selectedAccount = selectedAccount!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  LoginViewController.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Text fields
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //MARK: Buttons
    @IBAction func btnLogin_TouchUpInside(_ sender: UIButton) {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                // Sign in successful -> Go to homepage
                if user != nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountHomePage")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Registration Failed!", message: (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result: UIAlertAction) -> Void in
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

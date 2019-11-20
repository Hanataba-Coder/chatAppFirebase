//
//  LoginViewController.swift
//  chatAppFirebase
//
//  Created by Hanataba on 17/11/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                    // ...
                    if let e = error {
                        print("error from LoginPage: \(e.localizedDescription)")
                    }else{
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    }
                }
            
            
        }
    }
}

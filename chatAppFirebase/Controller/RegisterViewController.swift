//
//  RegisterViewController.swift
//  chatAppFirebase
//
//  Created by Hanataba on 17/11/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passTextField.text {
            
            if password.count < 6 {
                print("please enter password at least 6 words")
                
                passTextField.attributedPlaceholder = NSAttributedString(string: "Enter password at least 6 words",attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemPink])
            }else{
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    
                    if let e = error {
                        print("Error from RegistPage: \(e.localizedDescription)")
                    }
                    else{
                        self.performSegue(withIdentifier: "RegisterSegue", sender: self)
                    }
                    
                }
            }
            
        }
    }
}

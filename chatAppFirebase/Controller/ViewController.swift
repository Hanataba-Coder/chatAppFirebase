//
//  ViewController.swift
//  chatAppFirebase
//
//  Created by Hanataba on 17/11/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: CLTypingLabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        appTitle.text = "ChatApp"
    }


}


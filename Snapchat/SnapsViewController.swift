//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Stephen Romero on 2/9/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {
    
    @IBAction func logoutTapped(_ sender: Any) {
        //logs the user out when they press the logout button
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

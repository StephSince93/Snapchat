//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Stephen Romero on 2/9/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logoutTapped(_ sender: Any) {
        //logs the user out when they press the logout button
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
    
        return cell
    
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
           //creates object from the class User with the variables email and uid
            let snap = Snap()
            
      //      snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["description"] as! String

            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
        })
 
    }
    
}

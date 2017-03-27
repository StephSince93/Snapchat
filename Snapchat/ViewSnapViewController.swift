//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Stephen Romero on 3/27/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {
    
    
    var snap = Snap()

    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        descripLabel.text = snap.descrip
        
        print(snap.imageURL)
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Goodbye")
        //removes from Firebase
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
            FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
                print("Picture deleted from database storage")
        }
    }

}

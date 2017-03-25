//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Stephen Romero on 2/5/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func signinTapped(_ sender: Any)
    {
        //checks the username and password to see if credentials are correct
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            //if there is no user with the email the user imput
            if error != nil {
                print("Hey we have an error:\(error)")
                //the databse creates an account for the user
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    if error != nil{
                    print("Hey we have an error:\(error)")

                    }
                    else{
                        print("Created user Successfully!")
                        
                       //adds the user id and email to the firebase database
                       FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)

                    }
                })
            }
            else{
                //the user signed in successfully
                print("Signed in Successfully")
               self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        
    }
    
}


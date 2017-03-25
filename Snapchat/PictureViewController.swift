//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Stephen Romero on 2/10/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
     let image = info[UIImagePickerControllerOriginalImage] as! UIImage
     
     imageView.image = image
        
     imageView.backgroundColor = UIColor.clear
        
     imagePicker.dismiss(animated: true, completion: nil)
    
    }
    @IBAction func cameraTapped(_ sender: Any)
    {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
   
    @IBAction func nextTapped(_ sender: Any)
    {
        nextButton.isEnabled = false
        
        let imagesFolder =  FIRStorage.storage().reference().child("images")
        //compressed the photo into a JPEG format
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        //NSUUID().uuidString creates a unique name for the picute being saved to the database, so no duplicates
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil, completion:
            {(metadata, error) in
                
                print("We tried to upload")
                if error != nil{
                    print ("We have an error:\(error)")
                }
                else{
                    
                    //prints the url where the picture will be downloaded in firebase so user can look up
                 //     print(metadata?.downloadURL())
                    
                     self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
                }
                
        })

        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionText.text!
        
        
        
           }
    
}

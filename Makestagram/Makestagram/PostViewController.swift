//
//  PostViewController.swift
//  Salaam
//
//  Created by basira daqiq on 7/14/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    
    
    
    @IBAction func cancelButtonTopped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           let identifier = segue.identifier
            if identifier == "cancel"{
                print("Cancel button tapped")
                textViewWrite.text = ""
            } else if identifier == "save" {
                print("Save button tapped")
                
                if textViewWrite.text == "" {
                    print("text empty")
                }
                else{
                    
                    let text = Post(texts: "String", textHeight: textViewWrite.contentSize.height)

                    PostService.create(text: self.textViewWrite.text!, height: Int(textViewWrite.contentSize.height))
                
                
                // 1
                    let HomeViewController = segue.destination as! HomeViewController
                    // 2
                    HomeViewController.posts.append(text)
                }
            textViewWrite.text = ""
            }
            
            
        
    }
    
    @IBAction func submitButtonTopped(_ sender: UIButton) {
        
     //   let text = textField.text ?? ""
        print("HELOOOOOO")
      // sav creat an ansetense and save teh text inn the text view of ur post  textField.text =
        
    }
    
 

    @IBOutlet weak var textViewWrite: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBOutlet weak var submitButton: UIButton!
    

    
//    let photoHelper = MGPhotoHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        }
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        
    
    @IBAction func picPicker(_ sender: UIButton) {
        
       // photoHelper.presentActionSheet(from: self)
    }

}






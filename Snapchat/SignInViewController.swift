//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Selase Kwawu on 23/04/2017.
//  Copyright © 2017 Selase Kwawu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a ni b.
        
        
    }

    @IBAction func turnUpTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("we tried to sign in")
            
            if error != nil {
                print("We have an error")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("we tried to create a user")
                    
                    if error != nil {
                        print("We have an error creating user \(error!)")
                    }else{
                        
                        print("We Created user succeesfully")
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                   
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
            }else{
                print("We signed in successfully: \(String(describing: user?.email))")
                
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
    }
 
    
    func getClassName(obj : AnyObject) -> String
    {
        let objectClass : AnyClass! = object_getClass(obj)
        let className = objectClass.description()
        
        return className
    }


}


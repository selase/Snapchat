//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Selase Kwawu on 24/04/2017.
//  Copyright © 2017 Selase Kwawu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageURL = ""
    var descrip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with:  { (snapshot) in
            print(snapshot)
            
            
            let user = User()
            
            
            
            user.email = (snapshot.value as? NSDictionary)?["email"] as? String ?? ""
            user.uid = snapshot.key
            
            self.users.append(user)
        
            self.tableView.reloadData()
        })
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let snap = ["from": user.email, "description": descrip, "imageUrl": imageURL]
        
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
    }

}

//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Selase Kwawu on 23/04/2017.
//  Copyright © 2017 Selase Kwawu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth



class SnapsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var snaps: [Snap] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with:  { (snapshot) in
            
            print(snapshot)
            
            
            let snap = Snap()

            snap.imageURL = (snapshot.value as? NSDictionary)?["imageURL"] as? String ?? ""
            snap.from = (snapshot.value as? NSDictionary)?["from"] as? String ?? ""
            snap.descrip = (snapshot.value as? NSDictionary)?["descrip"] as? String ?? ""


            
            self.snaps.append(snap)
            
            //self.tableView.reloadData()
        })

    }

    

    @IBAction func logoutTapped(_ sender: Any) {
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


}

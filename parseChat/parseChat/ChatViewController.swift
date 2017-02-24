//
//  ChatViewController.swift
//  parseChat
//
//  Created by Sylvia Mach on 2/23/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var messageTableView: UITableView!

    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view initalization
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // add handler for pressing Send button
        sendButton.addTarget(self, action: #selector(sendMessageOnclick), for: .primaryActionTriggered)
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in 
            // query parse every second for all messages using Message class
            let query = PFQuery(className: "Message")
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            query.findObjectsInBackground {
                (objects: [PFObject]?, error: Error?) -> Void in
                if let error = error {
                    print("findObjects error: \(error)")
                } else {
                    if let objects = objects {
                        self.messages = objects
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMessageOnclick(){
        let text = messageTextField.text
        let message = PFObject(className: "Message")
        message["user"] = PFUser.current()
        message["text"] = text
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if success {
                print("Succesfully saved message!")
            }
            else{
                print("Error saving message!")
            }
        }
        
    }
    
    /*
     // MARK: - Table View
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = self.messages {
            return messages.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatViewCell
        let currentObject = self.messages?[indexPath.row]
        let message = currentObject?["text"] as! String
        if let user = currentObject?["user"] {
//                    print("\((user as! PFUser).username)")
            cell.messageLabel.text = (user as! PFUser).username! + ": " + message
            
            
        }
        else {
            cell.messageLabel.text = message
        }
        
        cell.messageLabel.sizeToFit()
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

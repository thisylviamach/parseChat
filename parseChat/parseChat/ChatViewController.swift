//
//  ChatViewController.swift
//  parseChat
//
//  Created by Sylvia Mach on 2/23/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.addTarget(self, action: #selector(sendMessageOnclick), for: .primaryActionTriggered)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMessageOnclick(){
        let text = messageTextField.text
        let message = PFObject(className: "Message")
        
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

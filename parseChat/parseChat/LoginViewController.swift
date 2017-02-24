//
//  ViewController.swift
//  parseChat
//
//  Created by Sylvia Mach on 2/23/17.
//  Copyright © 2017 Sylvia Mach. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signUpButton.addTarget(self, action: #selector(signUpOnClick), for: .primaryActionTriggered)
        logInButton.addTarget(self, action: #selector(logInOnClick), for: .primaryActionTriggered)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func signUpOnClick() {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = (error as NSError).userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                print("signUp: \(errorString)")
                
            } else {
                // Hooray! Let them use the app now.
                print("signUp: success")
            }
        }
    }
    
    func logInOnClick() {
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                if let errorString = (error as? NSError)?.userInfo["error"] as? NSString {
                    print("logIn: \(errorString)")
                }
            } else {
                print("logIn: success")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    
        
        
    }

}


//
//  ViewController.swift
//  Oustgram
//
//  Created by Alan Guan on 1/12/19.
//  Copyright © 2019 Alan Guan. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var RegisterLabel: UILabel!
    
    @IBOutlet weak var RegisterButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    var accountExited : Bool = false
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let gameScore = PFObject(className:"GameScore")
//        gameScore["score"] = 1337
//        gameScore["playerName"] = "Alan Shore"
//        gameScore["cheatMode"] = false
//        gameScore.saveInBackground {
//            (success: Bool, error: Error?) in
//            if (success) {
//                // The object has been saved.
//            } else {
//                // There was a problem, check error.description
//            }
//        }
        
        let query = PFQuery(className:"GameScore")
        query.getObjectInBackground(withId: "igrEUWtEHW") { (gameScore: PFObject?, error: Error?) in
            if let gameScore = gameScore {
                gameScore["final"] = true
                gameScore["score"] = 1500
                gameScore.saveInBackground(block: { (object, error) in
                    if object {
                        print("updated")
                    }
                })
                gameScore.deleteInBackground()
            } else if let err = error {
                print(error)
            }
        }
        
        
//        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        activityIndicator.center = self.view.center
//        activityIndicator.color = UIColor.red
//        activityIndicator.hidesWhenStopped = true
//        view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func LoginButtoned(_ sender: Any) {
        
        accountExited = !accountExited
        
        if accountExited {
            RegisterLabel.text = "Please login below"
            RegisterButton.setTitle("Log in", for: .normal)
            LoginButton.setTitle("Register", for: .normal)
            
        } else {
            RegisterLabel.text = "Please register below"
            RegisterButton.setTitle("Register", for: .normal)
            LoginButton.setTitle("Log in", for: .normal)
        }
        
    }
    
    @IBAction func RegisterorLoginButtoned(_ sender: Any) {
        if accountExited {
            SignInUser()
            
        } else {
            SignUpUser()
        }
        
    }
    
    
    func SignUpUser() {
        var user = PFUser()
        user.username = EmailTextField.text
        user.password = PasswordTextField.text
        user.email = EmailTextField.text
        // other fields can be set just like with PFObject
//        user["phone"] = "415-392-0202"
        if EmailTextField.text != nil || PasswordTextField.text != nil {
            user.signUpInBackground {
                (succeeded: Bool, error: Error?) in
                if let error = error {
                    let errorString = error._userInfo!["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                } else {
                    // Hooray! Let them use the app now.
                    
                }
            }
        }
        
    }
    
    func SignInUser() {
    
        var userName = EmailTextField.text
        var pwd = PasswordTextField.text
        
        if let email = userName {
            PFUser.logInWithUsername(inBackground: email, password: pwd!) { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "userTableSegue", sender: Any?.self)
                } else if (error != nil) {
                    print(error)
                }
            }
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userTableSegue" {
            let destination = segue.destination as! UserTableViewController
            
        }
    }
    
}


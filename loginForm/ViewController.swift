//
//  ViewController.swift
//  loginForm
//
//  Created by kariman eltawel on 02/05/2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var ContinueButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func ContinueAction(_ sender: Any) {
        guard let email = EmailField.text, !email.isEmpty,
              let password = PasswordField.text, !password.isEmpty else{
            print("Missing data")
            return
        }
        // if it is not empty we will pass data to firebase and check it
        // if there a failure present an alert
        // if user continue creat accont
        // check sign in on launch app
        // allow user to signout with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            
            guard let strongself = self else{
                return
            }
            
            guard error == nil else{
                //account creation
                strongself.showAccountCreation(email: email, password: password)
                return
            }
            print("you have signin")
            strongself.EmailField.isHidden = true
            strongself.PasswordField.isHidden = true
            strongself.loginLabel.isHidden = true
            strongself.ContinueButton.isHidden = true
            
        }
    }
    
    func showAccountCreation(email:String,password:String){
        let alert = UIAlertController(title: "Acoount Creation", message: "Would you like to create an account ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default,handler: {_ in
            Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self ]result, error in
                guard let strongself = self else{
                    return
                }
                
                guard error == nil else{
                    //account creation
                    print("account creation failed ")
                    return
                }
                print("you have signin")
                strongself.EmailField.isHidden = true
                strongself.PasswordField.isHidden = true
                strongself.loginLabel.isHidden = true
                strongself.ContinueButton.isHidden = true
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: {_ in
            
        }))
        present(alert, animated: true)
        
    }
    
}


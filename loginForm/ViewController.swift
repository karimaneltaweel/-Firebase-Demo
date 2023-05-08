//
//  ViewController.swift
//  loginForm
//
//  Created by kariman eltawel on 02/05/2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class ViewController: UIViewController {
    
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet weak var greenCircle: UIView!
    @IBOutlet weak var OrangeCicle: UIView!
    
    
    @IBOutlet weak var GoogleSignIn: UIButton!
    
    private let signoutButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.setTitle("signOut", for: .normal)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        border_of_shapes(size: 200, view: OrangeCicle)
        border_of_shapes(size: 200, view: greenCircle)
        GoogleSignIn.addTarget(self, action: #selector(googleSign) , for: .touchUpInside)



        if FirebaseAuth.Auth.auth().currentUser != nil {
            EmailField.isHidden = true
            PasswordField.isHidden = true
            loginLabel.isHidden = true
            ContinueButton.isHidden = true
            view.addSubview(signoutButton)
            signoutButton.addTarget(self, action: #selector(signoutfunc) , for: .touchUpInside)
            signoutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)

        }
    }
    
    @objc private func signoutfunc(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            EmailField.isHidden = false
            PasswordField.isHidden = false
            loginLabel.isHidden = false
            ContinueButton.isHidden = false
            signoutButton.removeFromSuperview()
        }
        catch{
            print("an error occuered")
        }
    }
    
    @IBAction func ContinueAction(_ sender: Any) {
        guard let email = EmailField.text, !email.isEmpty,
              let password = PasswordField.text, !password.isEmpty else{
            print("Missing data")
            return
        }
 
        
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
    
    
@objc private func googleSign(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              return
            // ...
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              return
            // ...
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in

                self.EmailField.isHidden = true
                self.PasswordField.isHidden = true
                self.loginLabel.isHidden = true
                self.ContinueButton.isHidden = true
                self.view.addSubview(self.signoutButton)
                self.signoutButton.addTarget(self, action: #selector(self.signoutfunc) , for: .touchUpInside)
                self.signoutButton.frame = CGRect(x: 20, y: 195, width: view.frame.size.width-40, height: 52)            }
        }
        
       
    }
    
    
}





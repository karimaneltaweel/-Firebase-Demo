//
//  MainController.swift
//  loginForm
//
//  Created by kariman eltawel on 09/05/2023.
//

import UIKit

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

            }
    

    
    
    @IBAction func signUp(_ sender: Any) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier:"SignUpController") as! SignUpController
        navigationController?.pushViewController(signup, animated: true)
    }

    @IBAction func singIn(_ sender: Any) {
        let signin = self.storyboard?.instantiateViewController(withIdentifier:"ViewController") as! ViewController
        navigationController?.pushViewController(signin, animated: true)
    }
    

}

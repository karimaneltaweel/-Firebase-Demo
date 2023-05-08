//
//  SignUpController.swift
//  loginForm
//
//  Created by kariman eltawel on 08/05/2023.
//

import UIKit

class SignUpController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOrder.layer.borderColor = UIColor.systemYellow.cgColor
        viewOrder.layer.borderWidth = 1
        viewOrder.layer.cornerRadius = 40
        viewOrder.layer.masksToBounds = true
        viewOrder.layer.shadowOffset = CGSizeMake(6, 6)
        viewOrder.layer.shadowColor = UIColor.white.cgColor
        viewOrder.layer.shadowOpacity = 0.1
        viewOrder.layer.shadowRadius = 4

    }
    



}

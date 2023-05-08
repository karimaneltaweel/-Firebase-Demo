//
//  SignUpController.swift
//  loginForm
//
//  Created by kariman eltawel on 08/05/2023.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var circle: UIView!
    
    @IBOutlet weak var BigCircle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        border_of_shapes(size: 134, view: circle)
        border_of_shapes(size: 154, view: BigCircle)


    }
    

}
 func border_of_shapes(size:Int,view:UIView){
    view.layer.cornerRadius = CGFloat(size)
    view.layer.shadowOffset = CGSizeMake(10,10)
}

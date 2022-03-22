//
//  RegisterViewController.swift
//  RevolteChat
//
//  Created by Mederbek on 19/3/22.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var titleError: UILabel!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        titleError.text = ""
        
        if let email  = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //If something wrong
                    self.titleError.text = e.localizedDescription
                    print(e.localizedDescription)
                } else {
                    //Navigate to chat controller
                    self.performSegue(withIdentifier: K.REGISTER_SEGUE, sender: self)
                }
            }
        }
    }
}

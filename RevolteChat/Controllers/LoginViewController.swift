//
//  LoginViewController.swift
//  RevolteChat
//
//  Created by Mederbek on 19/3/22.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var titleError: UILabel!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        titleError.text = ""
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.titleError.text = e.localizedDescription
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}

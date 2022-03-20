//
//  ViewController.swift
//  RevolteChat
//
//  Created by Mederbek on 19/3/22.
//

import UIKit

class WelcomeViewController: UIViewController {
   
    @IBOutlet weak var titleLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLable.text = ""
        
        var charIndex = 0.0
        
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLable.text?.append(letter)
            }
            charIndex += 1
        }
    }
}


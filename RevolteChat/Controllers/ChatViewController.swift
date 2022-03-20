//
//  ChatViewController.swift
//  RevolteChat
//
//  Created by Mederbek on 19/3/22.
//

import Foundation
import UIKit
import Firebase

class ChatViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    var messages: [Message] = [
        Message(sender: "redlbur@gmail.com", body: "Hi")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
        tableView.dataSource = self
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        title = K.appName
        navigationItem.hidesBackButton = true

    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
    
    
}

//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}

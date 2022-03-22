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
  
  let firestore = Firestore.firestore()
  @IBAction func sendPressed(_ sender: UIButton) {
    
    if let messageBody = messageTextfield.text,
       let messageSender = Auth.auth().currentUser?.email {
      firestore
        .collection(K.FStore.COLLECTION_NAME)
        .addDocument(
          data: [K.FStore.SENDER_FIELD: messageSender,
                 K.FStore.BODY_FIELD: messageBody,
                 K.FStore.DATE_FIELD: Date().timeIntervalSince1970]
        ) { error in
          if let err = error {
            print("Error: \(err)")
          } else {
            print("Saved data!")
            
            DispatchQueue.main.async {
              self.messageTextfield.text = ""
            }
          }
        }
    }
  }
  
  
  var messages: [Message] = [
    
  ]
  override func viewDidLoad() {
    super.viewDidLoad()
    title = K.APP_NAME
    navigationItem.hidesBackButton = true
    tableView.register(UINib(nibName: K.CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: K.CELL_IDENTIFIRE)
    tableView.dataSource = self
    loadMessages()
    
    
    messageTextfield.attributedPlaceholder = NSAttributedString(string: "Type something...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.8)])
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.0)]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
  }
  
  func loadMessages() {
    
    firestore.collection(K.FStore.COLLECTION_NAME)
      .order(by: K.FStore.DATE_FIELD)
      .addSnapshotListener { querySnapshot, error in
        
        self.messages = []
        
        if let err = error {
          print("Empty store or there some issue in Firestore: \(err)")
        } else {
          if let snapshotDocuments = querySnapshot?.documents {
            for doc in snapshotDocuments {
              let data = doc.data()
              if let messageSender = data[K.FStore.SENDER_FIELD] as? String, let messageBody = data[K.FStore.BODY_FIELD] as? String {
                let newMessage = Message(sender: messageSender, body: messageBody)
                self.messages.append(newMessage)
                
                
                DispatchQueue.main.async {
                  self.tableView.reloadData()
                  let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                  self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
                
              }
            }
          }
        }
      }
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
    let message = messages[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.CELL_IDENTIFIRE, for: indexPath) as! MessageCell
    cell.label.text = message.body
    
    if message.sender == Auth.auth().currentUser?.email {
      cell.leftImageView.isHidden = true
      cell.rightImageView.isHidden = false
      cell.messageBubble.backgroundColor = UIColor(named: K.Colors.WET_ASPHALT)
      cell.label.textColor = UIColor(named: K.Colors.CLOUDS)
    }
    else {
      cell.leftImageView.isHidden = false
      cell.rightImageView.isHidden = true
      cell.messageBubble.backgroundColor = UIColor(named: K.Colors.MIDNIGHT_BLUE)
      cell.label.textColor = UIColor(named: K.Colors.CLOUDS)
    }
    return cell
  }
}

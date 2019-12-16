//
//  ChatViewController.swift
//  chatAppFirebase
//
//  Created by Hanataba on 17/11/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    @IBOutlet weak var tableViewSelf: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var message: [Message] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessage()
        messageTextField.delegate = self
        tableViewSelf.dataSource = self
        tableViewSelf.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCellXib")
    }
    
    func loadMessage() {
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { documentSnapshot, error in
                self.message = []
                if let documents = documentSnapshot?.documents{
                    for document in documents {
                        // print("\(document.documentID) : \(document.data())")
                        let data = document.data()
                        if let sender = data["sender"] as? String, let body = data["body"] as? String {
                            print(sender)
                            print(body)
                            self.message.append(Message(sender: sender, message: body))
                            DispatchQueue.main.async {
                                self.tableViewSelf.reloadData()
                                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
                                self.tableViewSelf.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
                else {
                    print("Error fetching document: \(error!)")
                    return
                }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let newMessage = messageTextField.text , let sender = Auth.auth().currentUser?.email{
            db.collection("messages")
                .addDocument(data: [
                    "sender": sender,
                    "body": newMessage,
                    "date": Date().timeIntervalSince1970
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID")
                        DispatchQueue.main.async {
                            self.messageTextField.text = ""
                        }
                    }
            }
        }
    }
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageIndexPath = message[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCellXib", for: indexPath) as! MessageCell
        
        cell.messageLabel.text = messageIndexPath.message
        cell.otherName.text = messageIndexPath.sender
        
        if messageIndexPath.sender == Auth.auth().currentUser?.email {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.bubbleView.backgroundColor = UIColor(named: "BrandPurple")
            cell.otherName.isHidden = true
        }else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.bubbleView.backgroundColor = UIColor(named: "BrandBlue")
            cell.otherName.isHidden = false
        }
        return cell
    }
    
    
}

extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newMessage = messageTextField.text , let sender = Auth.auth().currentUser?.email{
            db.collection("messages")
                .addDocument(data: [
                    "sender": sender,
                    "body": newMessage,
                    "date": Date().timeIntervalSince1970
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID")
                        DispatchQueue.main.async {
                            self.messageTextField.text = ""
                        }
                    }
            }
        }
        return true
    }
}

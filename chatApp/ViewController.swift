//
//  ViewController.swift
//  chatApp
//
//  Created by West Agile Labs on 17/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatText: UILabel!
    var prefilledResponses: [String: [String]] = [
        "hi": ["Hey!", "Are you available for a now UI project?"],
        "yes!": ["Great, here is the SOW of the project", "Image"],
        "yes, sure please": ["Please share me"]
    ]
    var chatMessages: [ChatMessage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 12
        mainView.clipsToBounds = true
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        textField.inputView = UIView()
        chatTableView.register(chatTableViewCell.self, forCellReuseIdentifier: "chatTableViewCell")

        self.addImagesToTextField()
    }

    @IBAction func sendAction(_ sender: UIButton) {
        guard let messageText = textField.text, !messageText.isEmpty else { return }
        
        let userMessage = ChatMessage(sender: .user, content: messageText)
        chatMessages.append(userMessage)
        chatTableView.reloadData()
        
        textField.text = ""
        
        if let responseMessages = prefilledResponses[messageText.lowercased()] {
            for message in responseMessages {
                let prefilledMessage = ChatMessage(sender: .receiver, content: message)
                chatMessages.append(prefilledMessage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.chatTableView.reloadData()
                }
            }
        }
    }
    
    func addImagesToTextField() {
        let microphoneImageView = UIImageView(image: UIImage(named: "microphone"))
        microphoneImageView.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        microphoneImageView.contentMode = .scaleAspectFit
        
        let line38ImageView = UIImageView(image: UIImage(named: "line"))
        line38ImageView.frame = CGRect(x: 30, y: 0, width: 20, height: 20)
        line38ImageView.contentMode = .scaleAspectFit
        
        let addCircleImageView = UIImageView(image: UIImage(named: "addCircle"))
        addCircleImageView.frame = CGRect(x: 270, y: 0, width: 20, height: 20)
        addCircleImageView.contentMode = .scaleAspectFit
  
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        containerView.addSubview(microphoneImageView)
        containerView.addSubview(line38ImageView)
        containerView.addSubview(addCircleImageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatTableViewCell", for: indexPath) as! chatTableViewCell
            let messages = chatMessages[indexPath.row]
            cell.chatLabel?.text = messages.content
        
        if messages.sender == .user {
            cell.chatLabel?.textAlignment = .right
            cell.chatView?.backgroundColor = UIColor(red: 26/255, green: 143/255, blue: 237/255, alpha: 1.0)
        } else {
            cell.chatLabel?.textAlignment = .left
            cell.chatView?.backgroundColor = UIColor(red: 233/255, green: 243/255, blue: 251/255, alpha: 1.0)
        }
        return cell
    }
}

struct ChatMessage {
    let sender: ChatMessageSender
    let content: String
}

enum ChatMessageSender {
    case user, receiver
}


    





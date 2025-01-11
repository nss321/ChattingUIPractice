//
//  ChatBubbleViewController.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

final class ChattingViewController: UIViewController {

    var _chatRoom: ChatRoom?
    
    var chatRoom: ChatRoom {
        if let _chatRoom {
            return _chatRoom
        } else {
            print("failed to load chatroom")
            return ChatRoom(chatroomId: -1, chatroomImage: [], chatroomName: "")
        }
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configTextField()
        self.navigationItem.title = chatRoom.chatroomName
        // Do any additional setup after loading the view.
    }
    
    func configTextField() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.leftView = leftView
        
        var config = UIButton.Configuration.plain()
        let image = UIImage(systemName: "arrowtriangle.right")
        config.image = image
        config.baseBackgroundColor = .clear
        let rightButton = UIButton(
            configuration: config,
            primaryAction: UIAction { _ in
            self.sendButtonTapped()
        })
        textField.rightViewMode = .always
        textField.rightView = rightButton
        
        textField.attributedText = NSAttributedString(string: "메세지를 입력하세요.", attributes: [.foregroundColor : UIColor.label])
        textField.backgroundColor = .secondaryLabel
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
    }
    
    func sendButtonTapped() {
        print(textField.text!)
        textField.text = ""
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatRoom.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chatRoom.chatList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: OthersChatBubbleTableViewCell.identifier, for: indexPath) as! OthersChatBubbleTableViewCell
        
        cell.config(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: SingleChattingListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SingleChattingListTableViewCell.identifier)
        if chatRoom.chatroomId == -1 {
            let emptyLabel = UILabel()
            emptyLabel.text = "채팅 정보를 불러오는데 실패했어요 ;_;"
            tableView.backgroundColor = .gray
            tableView.addSubview(emptyLabel)
        } else {
        }
    }
}

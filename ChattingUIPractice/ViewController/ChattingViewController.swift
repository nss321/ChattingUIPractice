//
//  ChatBubbleViewController.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

final class ChattingViewController: UIViewController, ViewPresenstableProtocol {

    var _chatRoom: ChatRoom?
    
//    var chatRoom: ChatRoom {
//        if let _chatRoom {
//            return _chatRoom
//        } else {
//            print("failed to load chatroom")
//            return ChatRoom(chatroomId: 4,
//                            chatroomImage: [User.bran.profileImage],
//                            chatroomName: User.bran.rawValue,
//                            chatList: [
//                               Chat(user: .bran,
//                                    date: "2025-01-11 21:10",
//                                    message: "저번 과제 잘 봤습니다!!\n저번 과제에서 이러쿵 저러쿵 부분을 개선해볼 수 있을 것 같은데,\n그 부분까지 개선하셔서 다시 푸쉬해주실 수 있으시겠죠?\n설마 못한다고는 하지 않으시겠죠?"),
//                               Chat(user: .user,
//                                    date: "2025-01-12 11:12",
//                                    message: "브랜님! 다름 아니라 제가 어제 저녁에 쪼오오오끔 피곤해서 자느라 다 못했습니다...!"),
//                               Chat(user: .bran,
//                                    date: "2025-01-12 11:30",
//                                    message: "보고체계 진행하도록 하겠습니다. 수고하세요."),
//                               Chat(user: .user,
//                                    date: "2025-01-12 11:31",
//                                    message: "한번만 봐주세요.. 다음부터는 다 제출할게요 ㅠㅠㅠ"),
//                               Chat(user: .bran,
//                                    date: "2025-01-12 11:32",
//                                    message: "안됩니다."),
//                               Chat(user: .user,
//                                    date: "2025-01-12 16:30",
//                                    message: "예외처리로 한번만 봐주시면 안되나요...?"),
//                               Chat(user: .bran,
//                                    date: "2025-01-12 19:30",
//                                    message: "개발자는 예외처리를 싫어합니다."),
//                            ])
//        }
//    }
//    
    
    var chatRoom: ChatRoom {
        get {
            if let _chatRoom {
                return _chatRoom
            } else {
                print("failed to load chatroom")
                return ChatRoom(chatroomId: -1, chatroomImage: [], chatroomName: "")
            }
        }
        set {
            _chatRoom = newValue
        }
    }
    
    var dateSeparator: [String] {
        var separator: [String] = []
        
        chatRoom.chatList.forEach {
            separator.append($0.date)
        }
        
        return separator
    }
    
    var lastDay = "2000-01-01 00:00"
    
    @IBOutlet var failureLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    
    // MARK: viewDIdLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        failureLabel.isHidden = true
        configTableView()
        configTextField()
        configNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
                tableView.scrollToRow(at: IndexPath(row: chatRoom.chatList.count - 1, section: 0), at: .bottom, animated: true)
    }
    override func viewDidLayoutSubviews() {
        print(#function)
    }
    
    func configNavigationBar() {
        let buttonImage = UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.navigationItem.title = chatRoom.chatroomName
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    func configTextField() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.leftView = leftView
        
        var config = UIButton.Configuration.plain()
        let image = UIImage(systemName: "arrowtriangle.right")
        config.image = image?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        config.baseBackgroundColor = .clear
        let rightButton = UIButton(
            configuration: config,
            primaryAction: UIAction { _ in
            self.sendButtonTapped()
        })
        textField.rightViewMode = .always
        textField.rightView = rightButton
        
        textField.attributedPlaceholder = NSAttributedString(string: "메세지를 입력하세요.", attributes: [.foregroundColor : UIColor.secondaryLabel])
        textField.backgroundColor = .quaternaryLabel
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
    }
    
    func sendButtonTapped() {
        print(textField.text!)
        textField.text = ""
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: TableView Delegate
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatRoom.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chatRoom.chatList[indexPath.row]
        print(#function, indexPath.row)
        
        if lastDay == chatRoom.chatList.last?.date {
            lastDay = "2000-01-01 00:00"
            print("reset lastDay")
        }
        
        if DateFormatManager.shared.isNewDay(lastDay, row.date) {
            lastDay = row.date
            print("updated lastDay: \(row.date) ")
            switch row.user {
            case .user:
                let cell = tableView.dequeueReusableCell(withIdentifier: MyDateSeparatorTableViewCell.identifier, for: indexPath) as! MyDateSeparatorTableViewCell
                cell.config(row: row)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: OtherDateSeparatorTableViewCell.identifier, for: indexPath) as! OtherDateSeparatorTableViewCell
                cell.config(row: row)
                return cell
            }
        } else {
            let row = chatRoom.chatList[indexPath.row]
            switch row.user {
            case .user:
                let cell = tableView.dequeueReusableCell(withIdentifier: MyChatBubbleTableViewCell.identifier, for: indexPath) as! MyChatBubbleTableViewCell
                cell.config(row: row)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: OthersChatBubbleTableViewCell.identifier, for: indexPath) as! OthersChatBubbleTableViewCell
                cell.config(row: row)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: OthersChatBubbleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OthersChatBubbleTableViewCell.identifier)
        tableView.register(UINib(nibName: MyChatBubbleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MyChatBubbleTableViewCell.identifier)
        tableView.register(UINib(nibName: OtherDateSeparatorTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OtherDateSeparatorTableViewCell.identifier)
        tableView.register(UINib(nibName: MyDateSeparatorTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MyDateSeparatorTableViewCell.identifier)
        
        if chatRoom.chatroomId == -1 {
            print(#function)
//            let emptyLabel = UILabel()
//            emptyLabel.text = "채팅 정보를 불러오는데 실패했어요 ;_;"
//            tableView.backgroundColor = .gray
//            tableView.addSubview(emptyLabel)
            view.backgroundColor = .systemGray6
            tableView.isHidden = true
            failureLabel.isHidden = false
            textField.isEnabled = false
        } else {
        }
        
        // MARK: 이 방식으로 하단 스크롤 시 cell을 가장 아래부터 만들게 됩니다. 그러다보니 맨 위 메시지에는 시간 구분선이 나타나지 않는데, 어떤식으로 처리하면 좋을까요?
        // MARK: viewDidAppear에서 호출하는걸로 해결했습니다 ^^~
//        tableView.scrollToRow(at: IndexPath(row: chatRoom.chatList.count - 1, section: 0), at: .bottom, animated: true)
    }
}

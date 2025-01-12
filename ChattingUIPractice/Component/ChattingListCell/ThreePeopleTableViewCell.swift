//
//  ThreePeopleTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/12/25.
//

import UIKit

class ThreePeopleTableViewCell: UITableViewCell, ReusableViewProtocol {
    

    static let identifier = "ThreePeopleTableViewCell"
    
    @IBOutlet var firstProfileImageView: UIImageView!
    @IBOutlet var secondProfileImageView: UIImageView!
    @IBOutlet var chatRoomNameLabel: UILabel!
    @IBOutlet var latestMessageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var chatroomId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    func setupCell() {
        firstProfileImageView.clipsToBounds = true
        secondProfileImageView.clipsToBounds = true
        firstProfileImageView.contentMode = .scaleAspectFill
        secondProfileImageView.contentMode = .scaleAspectFill
        
        firstProfileImageView.layer.borderWidth = 2
        secondProfileImageView.layer.borderWidth = 2
        firstProfileImageView.layer.borderColor = UIColor.white.cgColor
        secondProfileImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    func config(row: ChatRoom) {
        let firstImage = row.chatroomImage[row.chatroomImage.endIndex-1]
        let secondImage = row.chatroomImage[row.chatroomImage.endIndex - 2]
        guard let firstProfile: UIImage = UIImage(named: firstImage) else {
            print("failed to load firstProfile")
            firstProfileImageView.image = UIImage(systemName: "person")
            return
        }
        guard let secondProfile: UIImage = UIImage(named: secondImage) else {
            print("failed to load secondProfile")
            secondProfileImageView.image = UIImage(systemName: "person")
            return
        }
        
        firstProfileImageView.image = firstProfile
        secondProfileImageView.image = secondProfile
        chatRoomNameLabel.text = row.chatroomName
        latestMessageLabel.text = row.chatList.last?.message
        dateLabel.text = DateFormatManager.shared.convertChatdateToDisplaydate(date: row.chatList.last?.date ?? "")
        chatroomId = row.chatroomId
        
    }
}

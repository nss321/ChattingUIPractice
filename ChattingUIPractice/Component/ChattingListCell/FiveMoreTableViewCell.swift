//
//  FiveMoreTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/12/25.
//

import UIKit

class FiveMoreTableViewCell: UITableViewCell, ReusableViewProtocol {
    
    static let identifier = "FiveMoreTableViewCell"
    
    @IBOutlet var firstProfileImageView: UIImageView!
    @IBOutlet var secondProfileImageView: UIImageView!
    @IBOutlet var thirdProfileImageView: UIImageView!
    @IBOutlet var fourthProfileImageView: UIImageView!
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
        thirdProfileImageView.clipsToBounds = true
        fourthProfileImageView.clipsToBounds = true
        firstProfileImageView.contentMode = .scaleAspectFill
        secondProfileImageView.contentMode = .scaleAspectFill
        thirdProfileImageView.contentMode = .scaleAspectFill
        fourthProfileImageView.contentMode = .scaleAspectFill
    }
    
    func config(row: ChatRoom) {
        let firstImage = row.chatroomImage[row.chatroomImage.startIndex]
        let secondImage = row.chatroomImage[row.chatroomImage.startIndex + 1]
        let thirdImage = row.chatroomImage[row.chatroomImage.startIndex + 2]
        let fourthImage = row.chatroomImage[row.chatroomImage.startIndex + 3]
        
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
        guard let thirdProfile: UIImage = UIImage(named: thirdImage) else {
            print("failed to load thirdProfile")
            thirdProfileImageView.image = UIImage(systemName: "person")
            return
        }
        guard let fourthProfile: UIImage = UIImage(named: fourthImage) else {
            print("failed to load thirdProfile")
            fourthProfileImageView.image = UIImage(systemName: "person")
            return
        }
        
        firstProfileImageView.image = firstProfile
        secondProfileImageView.image = secondProfile
        thirdProfileImageView.image = thirdProfile
        fourthProfileImageView.image = fourthProfile
        chatRoomNameLabel.text = row.chatroomName
        latestMessageLabel.text = row.chatList.last?.message
        dateLabel.text = DateFormatManager.shared.convertChatdateToDisplaydate(date: row.chatList.last?.date ?? "")
        chatroomId = row.chatroomId
    }
}

//
//  ChattingListTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

final class SingleChattingListTableViewCell: UITableViewCell, ReusableViewProtocol {

    static let identifier = "SingleChattingListTableViewCell"
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var latestMessageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var chatroomId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell() {
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleToFill
    }
    
    func config(row: ChatRoom) {
        guard let image = row.chatroomImage.last else {
            print("프로필 이미지 로드 실패1")
            return
        }
        guard let profile: UIImage = UIImage(named: image) else {
            print("프로필 이미지 로드 실패2")
            return
        }
        profileImage.image = profile
        latestMessageLabel.text = row.chatList.last?.message
        nameLabel.text = row.chatroomName 
        dateLabel.text = DateFormatManager.shared.convertChatdateToDisplaydate(date: row.chatList.last?.date ?? "")
        chatroomId = row.chatroomId
    }
}

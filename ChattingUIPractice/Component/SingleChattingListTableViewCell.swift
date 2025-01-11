//
//  ChattingListTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

final class SingleChattingListTableViewCell: UITableViewCell {

    static let identifier = "SingleChattingListTableViewCell"
    static let dateFormatter = DateFormatter()
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var latestMessageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var chatroomId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        latestMessageLabel.text = row.chatroomName
        nameLabel.text = row.chatList.last?.message
        dateLabel.text = DateFormatManager.shared.convertChatdateToDisplaydate(date: row.chatList.last?.date ?? "")
        chatroomId = row.chatroomId
    }
}

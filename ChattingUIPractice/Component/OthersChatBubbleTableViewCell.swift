//
//  ChatBubbleTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import UIKit

final class OthersChatBubbleTableViewCell: UITableViewCell {
    
    static let identifier = "OthersChatBubbleTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var messageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
    }
    
    func setupCell() {
        profileImageView.clipsToBounds = true
        messageLabel.clipsToBounds = true
        messageContainer.layer.cornerRadius = 12
        messageContainer.layer.borderColor = UIColor.black.cgColor
        messageContainer.layer.borderWidth = 1
        
    }
    
    func config(row: Chat) {
        profileImageView.image = UIImage(named: row.user.profileImage)
        nameLabel.text = row.user.profileImage
        messageLabel.text = row.message
        timeLabel.text = DateFormatManager.shared.convertChatdateToTime(date: row.date)
    }
}

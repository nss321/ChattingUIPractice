//
//  DateSeparatorTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/12/25.
//

import UIKit

class OtherDateSeparatorTableViewCell: UITableViewCell, ReusableViewProtocol {

    static let identifier = "OtherDateSeparatorTableViewCell"
    
    @IBOutlet var dateSeparatorLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var messageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        dateSeparatorLabel.text = DateFormatManager.shared.converToChatToSeparatorDate(date: row.date)
        profileImageView.image = UIImage(named: row.user.profileImage)
        nameLabel.text = row.user.profileImage
        messageLabel.text = row.message
        timeLabel.text = DateFormatManager.shared.convertChatdateToTime(date: row.date)
    }
}

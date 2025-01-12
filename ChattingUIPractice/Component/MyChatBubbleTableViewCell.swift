//
//  MyChatBubbleTableViewCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/12/25.
//

import UIKit

final class MyChatBubbleTableViewCell: UITableViewCell, ReusableViewProtocol {

    static let identifier = "MyChatBubbleTableViewCell"
    
    @IBOutlet var messageContainer: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        messageContainer.clipsToBounds = true
        messageContainer.layer.cornerRadius = 12
        messageContainer.layer.borderColor = UIColor.black.cgColor
        messageContainer.layer.borderWidth = 1
    }
    
    func config(row: Chat) {
        messageLabel.text = row.message
        timeLabel.text = DateFormatManager.shared.convertChatdateToTime(date: row.date)
    }
    
}

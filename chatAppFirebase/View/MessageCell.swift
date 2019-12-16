//
//  MessageCell.swift
//  chatAppFirebase
//
//  Created by Hanataba on 17/11/2562 BE.
//  Copyright © 2562 Hanataba. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var otherName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleView.layer.cornerRadius = bubbleView.frame.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  chatTableViewCell.swift
//  chatApp
//
//  Created by West Agile Labs on 17/03/24.
//

import UIKit

class chatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

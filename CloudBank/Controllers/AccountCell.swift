//
//  AccountCell.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {
    
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  TransactionCell.swift
//  CloudBank
//
//  Created by Nicolas Schmidt on 11/14/17.
//  Copyright © 2017 408 Industries. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var lblTransactionDate: UILabel!
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var lblTransactionAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

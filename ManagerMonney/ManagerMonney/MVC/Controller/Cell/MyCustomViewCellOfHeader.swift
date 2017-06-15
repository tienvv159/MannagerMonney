//
//  MyCustomViewCellOfHeader.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/9/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit

class MyCustomViewCellOfHeader: UITableViewCell {
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblMonney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  MyCustomTableViewCell.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/7/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDateSecsion: UILabel!
    @IBOutlet weak var lblIncomeTatol: UILabel!
    @IBOutlet weak var lblDayInWeek: UILabel!
    @IBOutlet weak var lblMonthAndYear: UILabel!
    @IBOutlet weak var lblExpensesTatol: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

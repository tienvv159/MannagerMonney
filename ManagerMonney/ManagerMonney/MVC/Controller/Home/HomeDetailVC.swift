//
//  HomeDetailVC.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/12/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit

class HomeDetailVC: UIViewController {

    @IBOutlet weak var imgIncome: UIImageView!
    @IBOutlet weak var imgExpenses: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var imgInfomation: UIImageView!

    
    
    var date:Date?
    var account:String?
    var category:String?
    var amount:String?
    var content:String?
    var check:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showDataInView()
    }
    
    func showDataInView() {
        
        let dateF = DateFormatter()
        dateF.dateFormat = "EEEE/dd/MM/yyy"
        lblDate.text = dateF.string(from: date!)
        
        lblCategory.text = category
        
        lblContent.text = content
        
        lblAmount.text = amount
    
        if check!{
            imgIncome.image = UIImage(named: "true")
        }else{
            imgExpenses.image = UIImage(named: "true")
        }
    }

}

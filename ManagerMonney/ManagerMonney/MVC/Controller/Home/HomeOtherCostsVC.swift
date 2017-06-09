//
//  HomeOtherCostsVC.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/7/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit

class HomeOtherCostsVC: UIViewController {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tfCategoryOther: UITextField!
    
    var dateOfHomeAddData:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDate.text = dateOfHomeAddData
    }
    
    @IBAction func btnOk(_ sender: Any) {
        if tfCategoryOther.text == "" {
            let alert = UIAlertController(title: "notification", message: "plase enter content category", preferredStyle: .alert)
            let btnOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(btnOK)
            present(alert, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "homeAddData") as! HomeAddDataVC
            vc.categoryOther = tfCategoryOther.text!
            vc.date = lblDate.text!
            if let navi = navigationController{
                navi.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    }

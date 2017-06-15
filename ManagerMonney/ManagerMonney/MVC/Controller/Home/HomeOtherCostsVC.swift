//
//  HomeOtherCostsVC.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/7/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit

protocol HomeOtherCostsDelegate{
    func editCategoty(text:String?)
}

class HomeOtherCostsVC: UIViewController {

    var delegate:HomeOtherCostsDelegate! = nil
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tfCategoryOther: UITextField!
    
    var dateOfHomeAddData:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDate.text = dateOfHomeAddData
        tfCategoryOther.becomeFirstResponder()
        self.createBtnDoneForKeyboard()
    }
    
    @IBAction func btnOk(_ sender: Any) {
            }
    
    func createBtnDoneForKeyboard() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        customView.backgroundColor = UIColor.groupTableViewBackground
        tfCategoryOther.inputAccessoryView = customView
        
        
        
        let btnDone = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(UIColor.blue, for: .normal)
        btnDone.addTarget(self, action: #selector(hendlingBtn), for: .touchUpInside)
        
        customView.addSubview(btnDone)

    }
    
    func hendlingBtn() {
        view.endEditing(true)
        
        if tfCategoryOther.text == "" {
            let alert = UIAlertController(title: "notification", message: "plase enter content category", preferredStyle: .alert)
            let btnOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(btnOK)
            present(alert, animated: true, completion: nil)
        }else{
            
            if delegate != nil{
                delegate.editCategoty(text: tfCategoryOther.text)
            }
            self.navigationController?.popViewController(animated: true)

        }

    }
    
    }

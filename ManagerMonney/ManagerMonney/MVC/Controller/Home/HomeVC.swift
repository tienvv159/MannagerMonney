//
//  HomeVC.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/5/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit
import RealmSwift




class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var lblIncome: UILabel!
    @IBOutlet weak var lblExpenses: UILabel!
    @IBOutlet weak var lblTatol: UILabel!
    
    let datePicker = UIDatePicker()
    var listSecsion = [DateData]()
    

    var totalIncome:Double = 0
    var totalExpenses:Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentDate()
        self.createDatePicker()
        self.addButtonInView()
        
        let nib = UINib(nibName: "MyCustomViewCellOfHeader", bundle: nil)
        
        myTableView.register(nib, forCellReuseIdentifier: "cellOfHearder")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromRealm()
        hendlingTotalMonney()
        myTableView.reloadData()
    }
    
    func hendlingTotalMonney() {
        var monneyIncome:Double = 0
        var monneyExpenses:Double = 0
        
        for item in listSecsion{
            monneyIncome += item.tatolIncome
        }
        
        lblIncome.text = String(format:"%.0f", monneyIncome)

        
        for item in listSecsion{
            monneyExpenses += item.tatolCost

        }
        lblExpenses.text =  String(format:"%.0f", monneyExpenses)
    }
    
    
    func addButtonInView() {
        var btnAddData = UIButton()
        btnAddData = UIButton(frame: CGRect(x: self.view.frame.size.width - 74, y: self.view.frame.height - 74, width: 64, height: 64))
        btnAddData.setImage(UIImage(named: "plus.png"), for: .normal)
        btnAddData.addTarget(self, action: #selector(addData), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(btnAddData)
        
    }
    
    func addData() {
        _ = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeAddData") as! HomeAddDataVC
        
        vc.date = tfDate.text!
        if let navi = navigationController {
            navi.pushViewController(vc, animated: true)
        }
        
        self.getDataFromRealm()
    }
    
    func getDataFromRealm() {
        
        do{
            let realm = try Realm()
            
            let listMonneyModel = realm.objects(MonneyModel.self)
        
            listSecsion.removeAll()
            
            for monneyModel in listMonneyModel{
                
                var indexExit: Int? = nil

                for (index, data) in listSecsion.enumerated() {
                    
                    if monneyModel.date == data.date {
                        indexExit = index
                        break
                    }
                }
                
                if let index = indexExit {
                    listSecsion[index].monneys.append(monneyModel)
                } else {
                    let date = DateData()
                    date.date = monneyModel.date
                    date.monneys.append(monneyModel)
                    listSecsion.append(date)
                }
            }
        }
        catch
        {
            
        }
    }
    
    
    func createDatePicker() {
        let toobar = UIToolbar()
        toobar.sizeToFit()
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePicker))
        toobar.setItems([btnDone], animated: false)
        
        tfDate.inputAccessoryView = toobar
        
        tfDate.inputView = datePicker
    }

    func donePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE/dd/MM/yyyy"
        tfDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func currentDate() {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE/dd/MM/yyyy"
        tfDate.text = dateFormatter.string(from: currentDate)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listSecsion.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSecsion[section].monneys.count + 1 // không có header của secsion nên phải +1 để có thêm 1 row chứa secsion
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCustomTableViewCell
            
            let dataDate =  listSecsion[indexPath.section]
            
            let date = dataDate.date
            let dateF = DateFormatter()
            dateF.dateFormat = "EEEE/dd/MM/yyyy"
            let dateDisplay = dateF.string(from: date)
            
            let arrDate = dateDisplay.components(separatedBy: "/")
            let dayInWeek = arrDate[0]
            let day = arrDate[1]
            let monthAndYear = "\(arrDate[2]).\(arrDate[3])"

            let datefomar = DateFormatter()
            datefomar.dateFormat = "EEEE/dd/MM/yyyy"
            cell.lblDateSecsion.text = day
            cell.lblDayInWeek.text = dayInWeek
            cell.lblMonthAndYear.text = monthAndYear
            
            cell.lblIncomeTatol.text = String(format: "%.0f",dataDate.tatolIncome)

            cell.lblExpensesTatol.text = String(format: "%.0f", dataDate.tatolCost)
            
            return cell

        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfHearder", for: indexPath) as! MyCustomViewCellOfHeader
            
            cell.lblCategory.text = listSecsion[indexPath.section].monneys[indexPath.row - 1].category
            
            let monneyIncomeAndExpenses = listSecsion[indexPath.section].monneys[indexPath.row - 1].monney

            if listSecsion[indexPath.section].monneys[indexPath.row - 1].isIncome {
                cell.lblIncome.text = String(format: "%.0f", monneyIncomeAndExpenses)
            }else{
                cell.lblExpenses.text = String(format: "%.0f", monneyIncomeAndExpenses)
            }
            
            return cell
        }
    }
    
}

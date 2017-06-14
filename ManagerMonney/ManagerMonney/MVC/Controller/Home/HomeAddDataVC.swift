//
//  HomeAddDataVC.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/6/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class HomeAddDataVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var mySegmented: UISegmentedControl!
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var lblDateDetailAddData: UILabel!
    @IBOutlet weak var tfCategory: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfContent: UITextField!
    
    var viewCollection = UIView()
    var imgData:Data!
    var date:String = ""
    var categoryOther:String = ""
    var myCollectionView:UICollectionView!
    var arrIncomeAndExpenses:[String]! = [""]
    var localPath:String = ""
    var tag:Int = 0
    var numberFirstTap:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfCategory.delegate = self
        tfCategory.text = categoryOther
        lblDateDetailAddData.text = date
        
        tfCategory.addTarget(self, action: #selector(createCollectionView), for: .touchDown)
        
        arrIncomeAndExpenses = ["ăn uống"," quần áo","thể thao", "đi chơi", "nhà trọ", "điện thoại", "tiền thuốc", "giáo dục", "sức khoẻ", "đi lại", "tiền lương", "làm thêm","tiền thưởng", "chi phí khác"]
        
        
        tfContent.delegate = self
        tfAmount.delegate = self
        tfCategory.delegate = self
        tfAccount.delegate = self
        
        tfAccount.tag = 100
        tfCategory.tag = 101
        tfAmount.tag = 102
        tfContent.tag = 103
        
        self.createInputAccessoryView()
        
    }
    
    func createInputAccessoryView() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        customView.backgroundColor = UIColor.groupTableViewBackground
        tfAccount.inputAccessoryView = customView
        tfAmount.inputAccessoryView = customView
        tfContent.inputAccessoryView = customView
        
        let btnBack = UIButton(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        btnBack.setImage(UIImage(named:"back.png"), for: .normal)
        btnBack.addTarget(self, action: #selector(backTextField), for: .touchUpInside)

        let btnNext = UIButton(frame: CGRect(x: 50  , y: 5, width: 40, height: 40))
        btnNext.setImage(UIImage(named:"next.png"), for: .normal)
        btnNext.addTarget(self, action: #selector(nextTextField), for: .touchUpInside)

        let btnDone = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50))
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(UIColor.blue, for: .normal)
        btnDone.addTarget(self, action: #selector(hendlingBtn), for: .touchUpInside)
        
        customView.addSubview(btnBack)
        customView.addSubview(btnNext)
        customView.addSubview(btnDone)

    }
    
    func hendlingBtn() {
        view.endEditing(true)
    }
    
    func nextTextField() {
        if tag == 100 {
            self.hendlingBtn()
            self.createCollectionView()
        }
        tag += 1
        self.view.viewWithTag(tag)?.becomeFirstResponder()
        
    }
    
    func backTextField() {
        if tag == 102 {
            self.hendlingBtn()
            self.createCollectionView()
        }
        tag -= 1
        self.view.viewWithTag(tag)?.becomeFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tag = textField.tag
        
    }
    

    
    func createCollectionView() {
        // không cho textField này hiện bàn phím
        let dummyView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        tfCategory.inputView = dummyView
        
        viewCollection = UIView(frame: CGRect(x: 0, y: self.view.frame.height / 2, width: self.view.frame.width, height: self.view.frame.height / 2))
        viewCollection.backgroundColor = UIColor.lightGray
        
        
        
        let toolbar = UIToolbar()
        let heightToobar:CGFloat = 50
        toolbar.frame = CGRect(x: 0, y: 0, width: viewCollection.frame.size.width, height: heightToobar)
        
        let btnCancel = UIBarButtonItem(image: (UIImage(named: "cancel.png")), style: .done, target: self, action: #selector(doneCollection))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let lblToolbar = UIBarButtonItem(title: "list category income and expenses", style: .plain, target: self, action: nil)
        
        lblToolbar.tintColor = UIColor.black
        toolbar.backgroundColor = UIColor.gray
        toolbar.setItems([lblToolbar , flexSpace , btnCancel], animated: false)

        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 120, height: 40)
        
        let nib = UINib(nibName: "MyCustomViewCell", bundle: nil)
        
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: heightToobar , width: viewCollection.frame.width, height: viewCollection.frame.height - heightToobar), collectionViewLayout: layout)
        
        myCollectionView.register(nib, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.backgroundColor = UIColor.clear
        
        viewCollection.addSubview(myCollectionView)
        viewCollection.addSubview(toolbar)
        self.view.addSubview(viewCollection)
    }
    
    
    func doneCollection() {
        viewCollection.isHidden = true
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrIncomeAndExpenses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCustomViewCell
        
        cell.backgroundColor = UIColor.white
        cell.lblCell.text = arrIncomeAndExpenses[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin:CGFloat = 1.0
        let itemWith:CGFloat = (myCollectionView.frame.size.width - margin * 2) / 3.0
        let itemSize = CGSize(width: itemWith, height: 40)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == arrIncomeAndExpenses.count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeOtherCosts") as! HomeOtherCostsVC
            vc.dateOfHomeAddData = lblDateDetailAddData.text!
            if let navi = navigationController{
                navi.pushViewController(vc, animated: true)
            }
        }else{
            tfCategory.resignFirstResponder()
            tfCategory.text = arrIncomeAndExpenses[indexPath.item]
            viewCollection.isHidden = true
        }
        
        
        tfAmount.becomeFirstResponder()
    }
    
    @IBAction func btnCamera(_ sender: Any) {
        
        let alert:UIAlertController = UIAlertController(title: "intification", message: "choosel", preferredStyle: .alert)
        
        let btnPhoto:UIAlertAction = UIAlertAction(title: "Photo", style: .default) { (UIAlertAction) in
            // code
            let imgPicker = UIImagePickerController()
            imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imgPicker.delegate = self
            imgPicker.allowsEditing = false // k cho thay doi hinh
            self.present(imgPicker, animated: true, completion: nil)
        }
        
        let btnCammera:UIAlertAction = UIAlertAction(title: "Cammera", style: .default) { (UIAlertAction) in
            // code
            
            if (UIImagePickerController.isSourceTypeAvailable(.camera)){
                
                let imgPicker = UIImagePickerController()
                imgPicker.sourceType = UIImagePickerControllerSourceType.camera
                imgPicker.delegate = self
                imgPicker.allowsEditing = false // k cho thay doi hinh
                self.present(imgPicker, animated: true, completion: nil)
            }else{
                self.showAlert(titleAlert: "notification", titleBtn: "OK", message: "This device doesn't have a camera!")
            }
        }
        
        let btnCancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            // code
            self.dismiss(animated: true, completion: nil)
        }


        alert.addAction(btnPhoto)
        alert.addAction(btnCammera)
        alert.addAction(btnCancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // khi chụp ảnh hay chọn từ photo đều gọi về hàm này
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // khởi tạo chooselimg = info(mặc định của hàm) as! vè UIImage
        let chooselImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // kiểm tra giá trị của img vì có thể các máy có độ phân giải khác nhau
        let imgValue = max(chooselImage.size.width, chooselImage.size.height)
        //so sách độ phân giải để điều chỉnh cho hợp lý
        if imgValue > 3000 {
            // độ phân giải này tính từ 0 - 1 (0.1 là về mức gần thấp nhất)
            imgData = UIImageJPEGRepresentation(chooselImage, 0.1)
        }else if imgValue > 2000{
            imgData = UIImageJPEGRepresentation(chooselImage, 0.3)
        }else{
            imgData = UIImagePNGRepresentation(chooselImage)
        }
        
        // cho imgInfo hiện lên bức ảnh vừa tạo
        imgInfo.image = UIImage(data: imgData)
        
        
        // get url image
        
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imagePath =  imageURL.lastPathComponent
        localPath = String(describing: NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagePath!))
        
       // print(localPath)
        
        // đóng cửa sổ ảnh đi
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaver(_ sender: Any) {
        
        do{
            let realm = try Realm()
            
            let monney = MonneyModel()
            monney.category = tfCategory.text!
            
            let dateF = DateFormatter()
            dateF.dateFormat = "EEEE/dd/MM/yyyy"
            monney.date = dateF.date(from: lblDateDetailAddData.text!) ?? Date()

            monney.monney = Double(tfAmount.text!)!
            
            //print(localPath)
            monney.imgInfo = localPath
            
            if mySegmented.selectedSegmentIndex == 0 {
                monney.isIncome = false
            }else{
                monney.isIncome = true
            }
            
            monney.content = tfContent.text!
            
            try realm.write {
                realm.add(monney)
                
                self.showAlert(titleAlert: "notification", titleBtn: "OK", message: "successfully save")
            }
            
        }catch{
            self.showAlert(titleAlert: "notification", titleBtn: "OK", message: "save failed")
        }
    }
    
    func showAlert(titleAlert:String , titleBtn:String , message:String) {
        let alert = UIAlertController(title: titleAlert, message: message, preferredStyle: .actionSheet)
        
        let btnOK = UIAlertAction(title: titleBtn, style: .default, handler: nil)
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    

}

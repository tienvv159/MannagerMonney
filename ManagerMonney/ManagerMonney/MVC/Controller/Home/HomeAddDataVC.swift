//
//  HomeAddDataVC.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/6/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import UIKit
import RealmSwift

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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfCategory.delegate = self
        tfCategory.text = categoryOther
        
        lblDateDetailAddData.text = date
        
        arrIncomeAndExpenses = ["ăn uống"," quần áo","thể thao", "đi chơi", "nhà trọ", "điện thoại", "tiền thuốc", "giáo dục", "sức khoẻ", "đi lại", "tiền lương", "làm thêm","tiền thưởng", "chi phí khác"]
    
    }
    
    
    @IBAction func tapTextfield(_ sender: Any) {
        self.createCollectionView()
    }
    
    
    func createCollectionView() {
        
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
                self.showAlert(titleAlert: "notification", titleBtn: "OK", message: "the device has no camera")
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
   //         print(monney.date)
            monney.monney = Double(tfAmount.text!)!
            
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

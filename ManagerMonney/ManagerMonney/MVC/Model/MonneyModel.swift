//
//  MonneyModel.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/7/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import Foundation
import RealmSwift

import UIKit
class MonneyModel : Object{
    
    dynamic var id:Int = 0

    dynamic var date:Date = Date()
    
    dynamic var monney:Double = 0
    
    dynamic var category:String = ""
        
    dynamic var isIncome:Bool = true
    
    dynamic var imgInfo:String?
    
    dynamic var content:String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}


//enum Monney: Int {
//    case income = 1
//    case cost = 2
//}

//
//  DataDateModel.swift
//  ManagerMonney
//
//  Created by Vu Van Tien on 6/9/2560 BE.
//  Copyright © 2560 BE MyStudio. All rights reserved.
//

import Foundation

class DateData{
    var date = Date()
    var monneys = [MonneyModel]()
    
    var tatolIncome:Double{
        var cost: Double = 0
        for money in monneys{
            if money.isIncome {
                cost += money.monney
            }
        }
        return cost
    }
    var tatolCost:Double{
        var cost: Double = 0
        for money in monneys{
            if !money.isIncome {
                cost += money.monney
            }
        }
        return cost
    }
}

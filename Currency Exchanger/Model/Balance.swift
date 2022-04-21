//
//  Balance.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import CoreData

class Balance: NSManagedObject {
    @NSManaged var currency: String
    @NSManaged var amount: String
}

//
//  Balance.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import CoreData

class BalanceResponse: Decodable {
    var currency: String
    var amount: String
}

class Balance: NSManagedObject {
    @NSManaged var currency: String
    @NSManaged var amount: String
}

//
//  BalanceResponse.swift
//  Currency Converter
//
//  Created by Vahid Sayad on 21/4/2022 .
//

import Foundation

class BalanceResponse: Decodable {
    var currency: String
    var amount: String
}

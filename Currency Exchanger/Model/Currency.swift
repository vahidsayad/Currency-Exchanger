//
//  Currency.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import Foundation

enum Currency: String, Decodable, CaseIterable {
    case eur = "EUR"
    case usd = "USD"
    case jpy = "JPY"
}

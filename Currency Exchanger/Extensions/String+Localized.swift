//
//  String+Localized.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 19/4/2022 .
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

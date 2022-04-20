//
//  BalanceView.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import SwiftUI

struct BalanceView: View {
    @Binding var balance: Balance
    
    var body: some View {
        HStack {
            Text(balance.amount)
            Text(balance.currency)
                .font(.system(.headline))
        }
    }
}

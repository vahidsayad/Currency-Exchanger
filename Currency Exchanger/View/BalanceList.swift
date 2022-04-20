//
//  BalanceList.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import SwiftUI

struct BalanceList: View {
    @Binding var balances: [Balance]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach($balances, id:\.self) { balance in
                    BalanceView(balance: balance)
                }
            }
        }
    }
}

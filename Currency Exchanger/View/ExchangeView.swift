//
//  ExchangeView.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 4/17/22.
//

import SwiftUI

struct ExchangeView: View {
    @FetchRequest(sortDescriptors: []) var balances: FetchedResults<Balance>
    @StateObject var vm: ExchangeView.ViewModel
    @Binding var amount: String
    @Binding var currency: Currency
    @State private var showCurrencyMenu = false
    
    var body: some View {
        VStack(spacing: 4) {
            GeometryReader { geo in
                HStack {
                    Image(systemName: vm.image)
                        .font(.system(.title2))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(
                            Circle()
                                .foregroundColor(vm.arrowBackcolor)
                        )
                        .padding(.trailing, 8)
                    HStack {
                        Text(vm.title)
                        
                        Spacer()
                        
                        if vm.isAmountEditable {
                            TextField("000", text: $amount)
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal)
                                .keyboardType(.decimalPad)
                        } else {
                            Text(amount)
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal)
                                .foregroundColor(vm.colorOfExchangedAmount(of: amount))
                        }

                        Menu {
                            ForEach(Currency.allCases, id:\.self) { currency in
                                Button {
                                    self.currency = currency
                                } label: {
                                    Label(currency.rawValue, systemImage: "checkmark.circle")
                                }
                            }
                        } label: {
                            HStack {
                                Text(currency.rawValue)
                                    .foregroundColor(.action)
                                Image(systemName: "greaterthan.circle")
                                    .font(.system(.title2))
                                    .rotationEffect(Angle(degrees: 90))
                                    .foregroundColor(.action)
                            }
                            .frame(minWidth: 70)
                        }
                    }
                }
            }
            Divider()
                .padding(.leading, 65)
        }
    }
}

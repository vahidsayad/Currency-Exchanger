//
//  RecieveView.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 4/17/22.
//

import SwiftUI

enum ExchangeViewType {
    case sell, recieve
}

extension ExchangeView {
    class ViewModel: ObservableObject {
        init(type: ExchangeViewType) {
            self.type = type
        }
        
        private var type: ExchangeViewType
        
        var title: String {
            switch type {
            case .sell:
                return "sell".localized
            case .recieve:
                return "recieve".localized
            }
        }
        
        var image: String {
            switch type {
            case .sell:
                return "arrow.up"
            case .recieve:
                return "arrow.down"
            }
        }
        
        var arrowBackcolor: Color {
            switch type {
            case .sell:
                return .red
            case .recieve:
                return .green
            }
        }
        
        func colorOfExchangedAmount(of amount: String) -> Color {
            guard let number = Double(amount) else { return .black }
            if number > 0 {
                return .green
            } else if number == 0 {
                return .black
            } else {
                return .red
            }
        }
        
        var isAmountEditable: Bool {
            switch type {
            case .sell:
                return true
            case .recieve:
                return false
            }
        }
    }
}

//
//  CurrencyButton.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 4/17/22.
//

import SwiftUI

struct CurrencyButton: View {
    var currency: String
    var action: ()->Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(currency)
            Image(systemName: "greaterthan.circle")
                .font(.system(.title2))
                .rotationEffect(Angle(degrees: 90))
        }
        .buttonStyle(.plain)
    }
}

struct CurrencyButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyButton(currency: "USD") {}
    }
}

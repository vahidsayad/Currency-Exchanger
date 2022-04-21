//
//  BalanceTitleModifier.swift
//  Currency Converter
//
//  Created by Vahid Sayad on 21/4/2022 .
//

import SwiftUI


struct BalanceTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.subheadline))
            .foregroundColor(Color.gray.opacity(0.8))
            .textCase(.uppercase)
            .padding()
    }
}

extension View {
    func balanceTitle() -> some View {
        self.modifier(BalanceTitleModifier())
    }
}

struct BalanceTitleModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("USD")
            .balanceTitle()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}

//
//  ContentView.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    private func initializeData() {
        let res = try? moc.count(for: NSFetchRequest<NSFetchRequestResult>(entityName: "Balance"))
        guard (res ?? 0) == 0 else { return }
        Currency.allCases.forEach { currency in
            let balance = Balance(context: moc)
            if currency == .eur {
                balance.amount = "1000"
            } else {
                balance.amount = "0"
            }
            
            balance.currency = currency.rawValue
            try? moc.save()
        }
    }
    
    var body: some View {
        HomeView()
            .environment(\.managedObjectContext, moc)
            .onAppear {
                initializeData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

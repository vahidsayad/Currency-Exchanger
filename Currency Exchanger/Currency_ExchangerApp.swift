//
//  Currency_ExchangerApp.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import SwiftUI

@main
struct Currency_ExchangerApp: App {
    
    init() {
        setupNavigationBarColor()
    }
    
    @StateObject private var dataController = DataController.shared

    
    private func setupNavigationBarColor() {
        let navColorAppearance = UINavigationBarAppearance()
        navColorAppearance.configureWithOpaqueBackground()
        navColorAppearance.backgroundColor = UIColor(red: 0.18, green: 0.48, blue: 1.00, alpha: 1.00)
        navColorAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        
        UINavigationBar.appearance().standardAppearance = navColorAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navColorAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.viewContext)
        }
    }
}

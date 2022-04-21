//
//  HomeView.ViewMode.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 19/4/2022 .
//

import SwiftUI
import CoreData

extension HomeView {
    class ViewModel: ObservableObject {
        private let dataController = DataController.shared
        private let exchangeLimitation = 7
        
        @Published var balances = [Balance]()
        @Published var amount = ""
        @Published var exchangedAmount = ""
        @Published var exchangeFrom = Currency.eur
        @Published var exchangeTo = Currency.usd {
            didSet {
                exchangedAmount = ""
            }
        }
        
        @Published var isLoading = false
        @Published var showError = false
        @Published var errorMessage = ""
        
        init() {
            self.balances = getBalances()
        }
        
        func exchange() {
            guard !isLoading else { return }
            guard isAmountValid(amount: amount) else { return }
            guard isAmounAvailable(amount: amount, of: exchangeFrom) else { return }
            
            isLoading = true
            
            ExchangeService.exchange(amount: amount.trimmingCharacters(in: .whitespacesAndNewlines),
                                     from: exchangeFrom,
                                     to: exchangeTo) { [weak self] balance, error in
                self?.isLoading = false
                if let error = error {
                    self?.showError(error)
                } else {
                    var numericAddAmount = Double(self?.amount ?? "") ?? 0
                    
                    self?.updateBalance(amount: Double(balance?.amount ?? "") ?? 0,
                                        currency: self!.exchangeTo,
                                        operation: .increment)
                    
                    self?.updateBalance(amount: numericAddAmount,
                                        currency: self!.exchangeFrom,
                                        operation: .decrement)
                    self?.amount = ""
                    self?.exchangedAmount = balance?.amount ?? "--"
                    self?.updateExchangeFreeFee()
                }
            }
        }
        
        private func exchangeInterest() -> Double {
            let exchangedCounter = UserDefaults.standard.integer(forKey: "ExchangedCounter")
            if exchangedCounter <= exchangeLimitation {
                return 0
            } else {
                return 0.07
            }
        }
        
        private func updateExchangeFreeFee() {
            var exchangedCounter = UserDefaults.standard.integer(forKey: "ExchangedCounter")
            exchangedCounter += 1
            UserDefaults.standard.set(exchangedCounter, forKey: "ExchangedCounter")
            UserDefaults.standard.synchronize()
        }
        
        enum CurrencyOperation {
            case increment, decrement
        }
        
        private func updateBalance(amount: Double, currency: Currency, operation: CurrencyOperation) {
            guard let target = getBalances().filter({$0.currency == currency.rawValue}).first else {
                fatalError("Balance not found!")
            }
            
            let numericAmount = Double(target.amount) ?? 0
            var finalAmount: Double = 0
            switch operation {
            case .increment:
                finalAmount = numericAmount + amount
            case .decrement:
                finalAmount = numericAmount - amount
                finalAmount -= (finalAmount * exchangeInterest())
            }
            
            target.amount = String(format: "%.2f", finalAmount)
            dataController.save()
            self.balances = self.getBalances()
        }
        
        private func isAmountValid(amount: String) -> Bool {
            guard Double(amount.trimmingCharacters(in: .whitespacesAndNewlines)) != nil else {
                self.showError("enter_valid_amount".localized)
                return false
            }
            return true
        }
        
        private func getBalances() -> [Balance] {
            let moc = dataController.viewContext
            
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Balance")
            fetchReq.sortDescriptors = [NSSortDescriptor(key: #keyPath(Balance.currency), ascending: true)]
            let balances = try? moc.fetch(fetchReq) as? [Balance]
            return balances ?? []
        }
        
        private func isAmounAvailable(amount: String, of currency: Currency) -> Bool {
            guard let balance = getBalances().filter({$0.currency == currency.rawValue}).first else {
                self.showError("currency_not_found".localized)
                return false
            }
            
            guard let numericAmount = Double(amount) else {
                self.showError("enter_valid_amount".localized)
                return false
            }
            
            guard let databaseAmount = Double(balance.amount) else {
                fatalError("INVALID DATA STORED IN DATABASE")
            }
            
            guard databaseAmount >= numericAmount - (numericAmount * exchangeInterest()) else {
                self.showError("amount_not_available".localized)
                return false
            }
            
            return true
        }
        
        private func showError(_ error: String) {
            self.errorMessage = error
            self.showError = true
        }
        
        func refresh() {
            self.balances = getBalances()
        }
    }
}

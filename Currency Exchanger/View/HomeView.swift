//
//  HomeView.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import SwiftUI

struct TitleModifier: ViewModifier {
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
        self.modifier(TitleModifier())
    }
}

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("my_balance")
                        .balanceTitle()
                    BalanceList(balances: $vm.balances)
                        .padding(.horizontal)
                        .padding(.bottom, 25)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("currency_exchange")
                        .balanceTitle()
                    
                    VStack(spacing: 18) {
                        ExchangeView(
                            vm: ExchangeView.ViewModel(type: .sell),
                            amount: $vm.amount,
                            currency: $vm.exchangeFrom)
                        .frame(height: 50)
                        
                        ExchangeView(
                            vm: ExchangeView.ViewModel(type: .recieve),
                            amount: $vm.exchangedAmount,
                            currency: $vm.exchangeTo)
                        .frame(height: 50)
                    }
                    .padding(.horizontal, 12)
                    .padding(.trailing, 8)
                    .padding(.bottom, 30)
                }
                HStack {
                    Spacer()
                    Button {
                        vm.exchange()
                    } label: {
                        HStack {
                            if vm.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                            Text("submit")
                                .foregroundColor(.white)
                            }
                        }
                        .frame(width: 260, height: 50)
                        .background(
                            Capsule()
                        )
                        .shadow(radius: 4)
                    }
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("currency_converter")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $vm.showError) {
                Alert(title: Text("error"), message: Text(vm.errorMessage), dismissButton: .default(Text("ok"), action: {
                }))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

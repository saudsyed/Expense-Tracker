//
//  TransactionListView.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 23/02/2024.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var viewModel: TransactionViewModel
    
    var body: some View {
        VStack {
            List {
                //MARK: Transaction Group
                ForEach(Array(viewModel.transactionGroupByMonth()), id: \.key) { month, transactions in
                    Section {
                        //MARK: Transaction List
                        ForEach(transactions) { transaction in
                            TransactionRowView(transactionData: transaction)
                        }
                    } header: {
                        //MARK: Month Header
                        Text(month)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static let transactionViewModel: TransactionViewModel = {
        let transactionViewModel = TransactionViewModel()
        transactionViewModel.transactionList = transactionListPreviewData
        return transactionViewModel
    }()
    
    static var previews: some View {
        NavigationView {
            TransactionListView()
        }
        .environmentObject(transactionViewModel)
    }
}

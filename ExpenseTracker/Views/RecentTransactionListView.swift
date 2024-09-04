//
//  RecentTransactionListView.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import SwiftUI

struct RecentTransactionListView: View {
    
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        VStack {
            HStack {
                //MARK: Header Title
                Text("Recent Transaction")
                    .bold()
                
                Spacer()
                
                //MARK: Header Link
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.textColor)
                }
            }
            .scenePadding(.top)
            
            //MARK: Transaction List
            ForEach(Array(transactionViewModel.transactionList.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRowView(transactionData: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionListView_Previews: PreviewProvider {
    static let transactionViewModel: TransactionViewModel = {
        let transactionViewModel = TransactionViewModel()
        transactionViewModel.transactionList = transactionListPreviewData
        return transactionViewModel
    }()
    
    static var previews: some View {
        RecentTransactionListView()
            .environmentObject(transactionViewModel)
    }
}

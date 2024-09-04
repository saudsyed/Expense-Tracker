//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    //MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //MARK: Transaction Chart
                    /// - data is a array of tuple (String, Double)
                    /// - total expense is a tuple and we extracting double from last tuple
                    let data = viewModel.accumulativeTransaction()
                    if !data.isEmpty {
                        let totalExpense = data.last?.1 ?? .zero
                        
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpense.formatted(.currency(code: "USD")), type: .title, format: "$%0.2f")
                                LineChart()
                            }
                            .background(Color.systemBackgroundColor)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: .systemBackgroundColor, foregroundColor: [ColorGradient(.iconColor.opacity(0.4), .iconColor)]))
                        .frame(height: 300)
                    }
                                        
                    //MARK: Transaction List
                    RecentTransactionListView()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.iconColor, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionViewModel: TransactionViewModel = {
        let transactionViewModel = TransactionViewModel()
        transactionViewModel.transactionList = transactionListPreviewData
        return transactionViewModel
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(transactionViewModel)
    }
}

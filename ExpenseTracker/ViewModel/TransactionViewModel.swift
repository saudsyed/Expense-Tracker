//
//  TransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import Foundation
import Combine
import Collections

typealias TransactionMonthGroup = OrderedDictionary<String, [TransactionData]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionViewModel: ObservableObject {
    
    @Published var transactionList: [TransactionData] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    //MARK: - getTransactions()
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [TransactionData].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transaction", error.localizedDescription)
                case .finished:
                    print("Finished fetching transaction")
                }
            } receiveValue: { [weak self] result in
                guard let strongSelf = self else { return }
                strongSelf.transactionList = result
            }
            .store(in: &cancellables)
    }
    
    //MARK: - transactionGroupByMonth()
    func transactionGroupByMonth() -> TransactionMonthGroup {
        guard !transactionList.isEmpty else { return [:] }
        let groupedTransaction = TransactionMonthGroup(grouping: transactionList, by: { $0.month })
        return groupedTransaction
    }
    
    //MARK: - accumulativeTransaction()
    /// - breaking down data into Chart data format
    /// - we use stride method to take out daily expense by date
    func accumulativeTransaction() -> TransactionPrefixSum {
        guard !transactionList.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed() // Today Date
        let dateInterval = Calendar.current.dateInterval(of: .yearForWeekOfYear, for: today)!
        print("Date Interval:", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactionList.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.rounded2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print("Date:", date.formatted(), "Daily Total:", dailyTotal, "Sum:", sum)
        }
        
        return cumulativeSum
    }
}

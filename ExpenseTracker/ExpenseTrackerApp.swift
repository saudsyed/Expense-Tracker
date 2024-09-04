//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionViewModel = TransactionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionViewModel)
        }
    }
}

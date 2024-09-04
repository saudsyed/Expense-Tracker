//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import Foundation
import SwiftUI

var transactionPreviewData = TransactionData(id: 1, date: "21/02/2024", institution: "Meezan Bank", merchant: "Apple", account: "Visa", amount: 11.49, type: "debit", category: "Software", categoryId: 801, isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [TransactionData](repeating: transactionPreviewData, count: 10)

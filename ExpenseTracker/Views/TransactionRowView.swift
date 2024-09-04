//
//  TransactionRowView.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRowView: View {
    
    var transactionData: TransactionData
    
    var body: some View {
        HStack(spacing: 20) {
            //MARK: Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.iconColor.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transactionData.icon), fontsize: 24, color: .iconColor)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                //MARK: Transaction Merchant
                Text(transactionData.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: Transaction Category
                Text(transactionData.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: Transaction Data
                Text(transactionData.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack {
                //MARK: Transaction Amount
                Text(transactionData.signedAmount, format: .currency(code: "USD"))
                    .bold()
                    .foregroundColor(transactionData.type == TransactionType.credit.rawValue ? .textColor : .primary)
            }
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transactionData: transactionPreviewData)
    }
}

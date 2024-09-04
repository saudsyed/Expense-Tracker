//
//  TransactionDataModel.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import Foundation
import SwiftUIFontIcon

//MARK: - TransactionData
struct TransactionData: Identifiable, Codable, Hashable {
    let id: Int
    let date: String
    let institution: String
    var merchant: String
    let account: String
    var amount: Double
    let type: TransactionType.RawValue
    var category: String
    var categoryId: Int
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var icon: FontAwesomeCode {
        if let category = CategoryData.allCategories.first(where: { $0.id == categoryId }) {
            return category.icon
        }
        return .question
    }
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

//MARK: - CategoryData
struct CategoryData {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}

//MARK: - Extension CategoryData
extension CategoryData {
    static let autoAndtransaport = CategoryData(id: 1, name: "Auto & Transaport", icon: .car_alt)
    static let billsAndUtilities = CategoryData(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = CategoryData(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = CategoryData(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = CategoryData(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = CategoryData(id: 6, name: "Home", icon: .home)
    static let income = CategoryData(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = CategoryData(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = CategoryData(id: 9, name: "Transfer", icon: .exchange_alt)
    
    static let publicTransportation = CategoryData(id: 101, name: "Public Transportation", icon: .bus, mainCategoryId: 1)
    static let taxi = CategoryData(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
    static let mobilePhone = CategoryData(id: 201, name: "Mobile Phone", icon: .mobile_alt, mainCategoryId: 2)
    static let movieAndDVDs = CategoryData(id: 301, name: "Movie & DVDs", icon: .film, mainCategoryId: 3)
    static let bankFee = CategoryData(id: 401, name: "Bank Fee", icon: .hand_holding_usd, mainCategoryId: 4)
    static let financeCharges = CategoryData(id: 402, name: "Finance Charges", icon: .hand_holding_usd, mainCategoryId: 4)
    static let groceries = CategoryData(id: 501, name: "Groceries", icon: .shopping_basket, mainCategoryId: 5)
    static let resturant = CategoryData(id: 502, name: "Resturant", icon: .utensils, mainCategoryId: 5)
    static let rent = CategoryData(id: 601, name: "Rent", icon: .house_user, mainCategoryId: 6)
    static let homeSupplies = CategoryData(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryId: 6)
    static let payCheque = CategoryData(id: 701, name: "Paycheque", icon: .dollar_sign, mainCategoryId: 7)
    static let software = CategoryData(id: 801, name: "Software", icon: .icons, mainCategoryId: 8)
    static let creditCardPayment = CategoryData(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryId: 9)
}

extension CategoryData {
    static let categories: [CategoryData] = [
        .autoAndtransaport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategories: [CategoryData] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .movieAndDVDs,
        .bankFee,
        .financeCharges,
        .groceries,
        .resturant,
        .rent,
        .homeSupplies,
        .payCheque,
        .software,
        .creditCardPayment
    ]
    
    static let allCategories: [CategoryData] = categories + subCategories
}

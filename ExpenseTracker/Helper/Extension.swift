//
//  Extension.swift
//  ExpenseTracker
//
//  Created by Saud Syed on 21/02/2024.
//

import Foundation
import SwiftUI

//MARK: - Color
extension Color {
    static let backgroundColor = Color("Background")
    static let iconColor = Color("Icon")
    static let textColor = Color("Text")
    static let systemBackgroundColor = Color(.systemBackground)
}

//MARK: - DateFormatter
extension DateFormatter {
    static let allNuemricUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

//MARK: - String
extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNuemricUSA.date(from: self) else { return Date() }
        return parsedDate
    }
}

//MARK: - Date
extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

//MARK: - Double
extension Double {
    func rounded2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}

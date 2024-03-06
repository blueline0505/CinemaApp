//
//  Date+Extention.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/6.
//

import Foundation

extension Date {
    func fromString(_ dateStr: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateStr)
    }
}

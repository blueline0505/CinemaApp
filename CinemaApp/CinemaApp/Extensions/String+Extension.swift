//
//  String+Extension.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/6.
//

import Foundation

extension String {
    func dateFormate(_ formatter: String = "yyyyMMdd") -> String {
        guard let date = Date().fromString(self) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: date)
    }
}

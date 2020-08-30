//
//  Date+Extension.swift
//  RyanAir
//
//  Created by Marcelo Laprea on 30/08/2020.
//  Copyright © 2020 Marcelo Laprea. All rights reserved.
//

import Foundation

extension Date {
    func formatDate(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func formatDateFromString(formatToConvert: String, fromFormat: String, stringDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        let date = dateFormatter.date(from: stringDate)
        
        return date?.formatDate(with: formatToConvert)
    }
}

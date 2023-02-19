//
//  String+ToDate.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 11..
//

import Foundation

extension String {
    func toFormattedDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale   = Locale(identifier: "en_US")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        
        // If for some reason the date from the API can't be formatted "Unknown date" will be returned.
        guard let date = dateFormatter.date(from: self) else {
            return "Unknown date"
        }
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        let formattedDateString = dateFormatter.string(from: date)
        
        return formattedDateString
    }
}

//
//  DateService.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 07.06.2022.
//

import Foundation

class DateService {
    
    static func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        guard let date = dateFormatter.date(from: date) else { return "Нет даты" }
        dateFormatter.dateFormat = "dd MMMM"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

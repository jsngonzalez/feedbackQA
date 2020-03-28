//
//  Date.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import UIKit

extension Date {
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
}

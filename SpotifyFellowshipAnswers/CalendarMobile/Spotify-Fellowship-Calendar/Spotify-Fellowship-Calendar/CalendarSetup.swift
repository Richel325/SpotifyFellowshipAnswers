//
//  CalendarView.swift
//  Spotify-Fellowship-Calendar
//
//  Created by Richel Cuyler on 7/4/18.
//  Copyright © 2018 Richel Cuyler. All rights reserved.
//

import Foundation






//Correct first date of the month
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}


//Retrieve date from date string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

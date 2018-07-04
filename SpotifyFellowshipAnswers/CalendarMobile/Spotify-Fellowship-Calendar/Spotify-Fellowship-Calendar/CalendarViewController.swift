//
//  ViewController.swift
//  Spotify-Fellowship-Calendar
//
//  Created by Richel Cuyler on 6/28/18.
//  Copyright © 2018 Richel Cuyler. All rights reserved.
//

import UIKit
import Foundation


//MONTH SETUP WITH DELEGATE FUNCTION
protocol MonthDelegate: AnyObject {
    func monthDidChange(monthIndex: Int, year: Int)
}


class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MonthDelegate {
    

    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var numberOfDaysInAMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex = 0
    var currentYear = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstMonthWeekDay = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, fromL Date())
        
        //Account for leap years!
        if currentMonthIndex == 1 && currentYear % 4 ==0 {
            numberOfDaysInAMonth[currentMonthIndex - 1] = 29
        }
      
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
        
        func monthDidChange(monthIndex: Int, year: Int) {
            return currentYear
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfDaysInAMonth[currentMonthIndex - 1] + firstMonthWeekDay - 1
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath)
        }
        return cell
    }
    
    
    
    //Calculate the first week day of each month
    func firstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex) - 1)".date?.firstDayOfMonth.weekday)!
        return day
    }
    
    
    //Calculate days of the month based on the month in the months array
    func monthDidChange(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        //Account for leap years!
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numberOfDaysInAMonth[monthIndex] = 29
            } else {
                numberOfDaysInAMonth[monthIndex] = 28
            }
        }
        firstMonthWeekDay = firstWeekDay()
    }
    
    
    
    
    
    
    class Month {
        var delegate: MonthDelegate?

        init(){
            currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
            currentYear = Calendar.current.component(.year, from: Date())
        }
    }
    
    
    
    
    
    
    
    
    //LAST MONTH - MOVE BACKWARDS
    @IBAction func backMonthButton(_ sender: Any) {
        currentMonthIndex -= 1
        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
        
        monthLabel.text = "\(Month.init().months[currentMonthIndex])  \(currentYear)"
        delegate?.monthDidChange(monthIndex: currentMonthIndex, year: currentYear)
        
    }
    
    //NEXT MONTH - MOVE FORWARD
    @IBAction func forwardMonthButton(_ sender: Any) {
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
    }
    
    monthLabel.text = "\(Month.init().months[currentMonthIndex])  \(currentYear)"
    delegate?.monthDidChange(monthIndex: currentMonthIndex, year: currentYear)
    
}










//DATE EXTENSION
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


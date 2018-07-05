//
//  ViewController.swift
//  Spotify-Fellowship-Calendar
//
//  Created by Richel Cuyler on 6/28/18.
//  Copyright © 2018 Richel Cuyler. All rights reserved.
//

import UIKit
import Foundation


class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var numberOfDaysInAMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex = 0
    var currentYear = 0
    var todaysDate = 0
    var firstMonthWeekDay = 0
    var presentMonthIndex = 0
    var presentYear = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        monthLabel.text = "\(months[currentMonthIndex - 1])  \(currentYear)"
        daysCollectionView.reloadData()
        
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numberOfDaysInAMonth[currentMonthIndex - 1] = 29
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInAMonth[currentMonthIndex - 1] + firstMonthWeekDay - 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCollectionViewCell
        if indexPath.item <= firstMonthWeekDay - 2 {
            cell.isHidden = true
        } else {
            let calculatedDate = indexPath.row - firstMonthWeekDay + 2
            cell.isHidden = false
            //cell.dateLabel.text = "\(calculatedDate)"
            if calculatedDate < todaysDate && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                cell.isUserInteractionEnabled = false
                //cell.dateLabel.text.backgroundColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled = false
                //cell.dateLabel.text.backgroundColor = UIColor.white
            }
        }
        return cell
    }
    
    
    
    
    //Calculate the first week day of each month
    func firstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfMonth.weekday)
        return day!
    }
    
    
    //Calculate days of the month based on the month in the months array
    func monthDidChange(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex
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
        
        daysCollectionView.reloadData()
    }
    
    
    
    
    
    //LAST MONTH - MOVE BACKWARDS
    @IBAction func backMonthButton(_ sender: Any) {
        currentMonthIndex -= 1
        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
        
        monthLabel.text = "\(months[currentMonthIndex])  \(currentYear)"
        monthDidChange(monthIndex: currentMonthIndex, year: currentYear)
        
    }
    
    
    
    //NEXT MONTH - MOVE FORWARD
    @IBAction func forwardMonthButton(_ sender: Any) {
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
        monthLabel.text = "\(months[currentMonthIndex])  \(currentYear)"
        monthDidChange(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    
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


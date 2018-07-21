//
//  Event.swift
//  Spotify-Fellowship-Calendar
//
//  Created by Richel Cuyler on 7/15/18.
//  Copyright © 2018 Richel Cuyler. All rights reserved.
//

import Foundation


class Event {
    var id: Int
    var name: String
    var start: Int
    var end: Int
    
    init(id: Int, name: String, start: Int, end: Int){
        self.id = id
        self.name = name
        self.start = start
        self.end = end
    }
    
}

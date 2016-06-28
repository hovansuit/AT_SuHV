//
//  Student.swift
//  Exercise4_CustomCell_Navi
//
//  Created by Mylo Ho on 6/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class Student {
    var name = ""
    var avatar = ""
    var age = 0
    var gender = true
    
    init(name: String, avatar: String, age: Int, gender: Bool){
        self.name = name
        self.avatar = avatar
        self.age = age
        self.gender = gender
    }
}
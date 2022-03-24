//
//  User.swift
//  Form
//
//  Created by Abhishek Kumar on 23/03/22.
//

import Foundation

class User {
    var firstname: String
    var lastName: String
    var gender: String?
    var age: Int
    
    init(firstName: String, lastName: String, gender: String?, age: Int
    ) {
        self.firstname = firstName
        self.lastName = lastName
        self.gender = gender
        self.age = age
    }
}

enum Gender: String,CaseIterable {
//    case None
    case Male
    case Female
    case Other
    
    var description: String {
        switch self {
//        case .None:
//            return "None"
        case .Male:
            return "Male"
        case .Female:
            return "Female"
        case .Other:
            return "Other"
        }
    }
}

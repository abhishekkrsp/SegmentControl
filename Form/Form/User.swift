//
//  User.swift
//  Form
//
//  Created by Abhishek Kumar on 23/03/22.
//

import Foundation

@propertyWrapper
struct GreaterThanTwenty {
    private var number: Int?
    var wrappedValue: Int? {
        get { return number }
        set {
            if let newValue = newValue, newValue > 20 {
                number = newValue
            } else {
                number = nil
            }
        }
    }
}

struct User {
    private var firstname: String
    private var lastName: String
    private var gender: String?
    @GreaterThanTwenty private var age: Int?
    
    init?(firstName: String?, lastName: String?, gender: String?, age: Int?
    ) {
        guard let firstName = firstName, let lastName = lastName, !firstName.isEmpty, !lastName.isEmpty else {
            return nil
        }
        self.firstname = firstName
        self.lastName = lastName
        self.gender = gender
        self.age = age
        if self.age == nil {
            return nil
        }
    }
    func printIdentity() -> String {
        return "Name: \(firstname + " " + lastName)\n Age: \(age ?? 0)\n Gender: \(gender ?? "Not Provided")"
    }
}

enum Gender: String,CaseIterable {
    case Male
    case Female
    case Other
    
    var description: String {
        switch self {
        case .Male:
            return "Male"
        case .Female:
            return "Female"
        case .Other:
            return "Other"
        }
    }
}

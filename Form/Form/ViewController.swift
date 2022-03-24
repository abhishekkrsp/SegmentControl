//
//  ViewController.swift
//  Form
//
//  Created by Abhishek Kumar on 23/03/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var genderOptions: UISegmentedControl!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var submit: UIButton!
    var user: User?
    var dataFirstName: String?
    var dataLastName: String?
    var dataAge: Int?
    var dataGender: String?
    
    @IBAction func actionForSubmit(_ sender: Any) {
        print(genderOptions.selectedSegmentIndex)
        dataGender = genderOptions.selectedSegmentIndex >= 0 ? genderOptions.titleForSegment(at: genderOptions.selectedSegmentIndex) : nil
        guard let dataFirstName = dataFirstName, let dataLastName = dataLastName, let dataAge = dataAge else {
            return
        }
        user = User(firstName: dataFirstName, lastName: dataLastName, gender: dataGender, age: dataAge)
        showAlert(with: "Sucess", and: "Name: \(dataFirstName + " " + dataLastName)\n Age: \(dataAge)\n Gender: \(user?.gender ?? "Not Provided")")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsForGender()
        firstName.delegate = self
        lastName.delegate = self
        age.delegate = self
        firstName.becomeFirstResponder()
    }
    
    func optionsForGender() {
        genderOptions.removeAllSegments()
        for gender in Gender.allCases {
            genderOptions.insertSegment(withTitle: gender.rawValue, at: genderOptions.numberOfSegments, animated: true)
        }
    }
    
    //MARK: TextFieldDelegate
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 255:
            dataFirstName = textField.text
        case 355:
            dataLastName = textField.text
        case 555:
            dataAge = Int(textField.text ?? "0")
        default:
            print("under default")
        }
        
        guard let dataFirstName = dataFirstName, let dataLastName = dataLastName, let dataAge = dataAge else {
            submit.isEnabled = false
            return
        }
        
        if dataFirstName.isEmpty || dataLastName.isEmpty || dataAge <= 20 {
            submit.isEnabled = false
            return
        }
        
        submit.isEnabled = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length > 0 {
            return true
        }
        var characterSetAllowed: CharacterSet
        switch textField.tag {
        case 255:
            characterSetAllowed = CharacterSet.letters
        case 355:
            characterSetAllowed = CharacterSet.letters
        case 555:
            characterSetAllowed = CharacterSet.decimalDigits
            guard let upcomingAge = Int((textField.text ?? "0") + string) else {
                return false
            }
            if upcomingAge > 150 {
                return false
            }
        default:
            characterSetAllowed = CharacterSet.decimalDigits
        }
        
        if let rangeOfCharactersAllowed = string.rangeOfCharacter(from: characterSetAllowed, options: .caseInsensitive) {
          let validCharacterCount = string.distance(from: rangeOfCharactersAllowed.lowerBound, to: rangeOfCharactersAllowed.upperBound)
          return validCharacterCount == string.count
        } else  {
          return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            default:
                print("unknown")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


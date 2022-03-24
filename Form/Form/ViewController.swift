//
//  ViewController.swift
//  Form
//
//  Created by Abhishek Kumar on 23/03/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Variables, Constants, Outlets
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var genderOptions: UISegmentedControl!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    private var user: User?
    private var dataFirstName: String?
    private var dataLastName: String?
    private var dataAge: Int?
    private var dataGender: String?
    
    //MARK: Overrided Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsForGender()
        firstName.delegate = self
        lastName.delegate = self
        age.delegate = self
        firstName.becomeFirstResponder()
        
        addDoneCancelToolbar(age)
        
        //MARK: Notification Obserbers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: Actions
    @IBAction func actionForSubmit(_ sender: Any) {
        if let user = user {
            showAlert(with: "Sucess", and: user.printIdentity())
        }
    }
    @IBAction func actonForSegmentControl(_ sender: UISegmentedControl) {
        dataGender = sender.titleForSegment(at: sender.selectedSegmentIndex)
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
            log("Default textFieldDidChangeSelection")
        }
        user = User(firstName: dataFirstName, lastName: dataLastName, gender: dataGender, age: dataAge)
        guard user != nil else {
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
    
    //MARK: Custom Functions
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: .none))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func optionsForGender() {
        genderOptions.removeAllSegments()
        for gender in Gender.allCases {
            genderOptions.insertSegment(withTitle: gender.rawValue, at: genderOptions.numberOfSegments, animated: true)
        }
    }
    
    func addDoneCancelToolbar(_ sender: UITextField) {
        let onCancel = (target: self, action: #selector(cancelButtonTapped))
        let onDone = (target: self, action: #selector(doneButtonTapped))
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: onDone.action)
        ]
        toolbar.sizeToFit()
        sender.inputAccessoryView = toolbar
    }
    
    // MARK: Selectors
    @objc func cancelButtonTapped(_ sender: UITextField) { view.endEditing(true)}
    @objc func doneButtonTapped(_ sender: UITextField) { view.endEditing(true)}

    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 25
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    //MARK: Debug logs
    private func log(_ expression: @autoclosure () -> Any) {
        #if DEBUG
        print(expression())
        #endif
    }
}

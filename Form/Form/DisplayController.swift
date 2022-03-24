//
//  DisplayController.swift
//  Form
//
//  Created by Abhishek Kumar on 24/03/22.
//

import Foundation
import UIKit

protocol DisplayDetails: AnyObject {
    func returnName() -> String
    func returnAge() -> String
    func returnGender() -> String
}
class UIDisplayController: UIViewController {
    weak var delegate: DisplayDetails?
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let delegate = delegate {
            nameLabel.text = delegate.returnName()
            ageLabel.text = delegate.returnAge()
            genderLabel.text = delegate.returnGender()
        }
    }
}

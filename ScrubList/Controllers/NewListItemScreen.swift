//
//  NewListItemScreen.swift
//  ScrubList
//
//  Created by Vargas, Greg on 12/30/20.
//

import UIKit

class NewListItemScreen: UIViewController {
    @IBOutlet weak var newItemNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        newItemNameTextField.becomeFirstResponder()
        newItemNameTextField.delegate = self
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let newItemName = newItemNameTextField.text, !newItemName.isEmpty {
            print(newItemName)
            newItemNameTextField.text = ""
            newItemNameTextField.resignFirstResponder()
        } else {
            print("Type something")
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NewListItemScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newItemNameTextField.resignFirstResponder()
        
        return true
    }
}

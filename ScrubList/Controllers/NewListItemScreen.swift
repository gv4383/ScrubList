//
//  NewListItemScreen.swift
//  ScrubList
//
//  Created by Vargas, Greg on 12/30/20.
//

import UIKit

protocol SaveNewItemDelegate {
    func didSaveNewItem(newItem: Item)
}

class NewListItemScreen: UIViewController {
    @IBOutlet weak var newItemNameTextField: UITextField!
    
    var saveNewItemDelegate: SaveNewItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        newItemNameTextField.becomeFirstResponder()
        newItemNameTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newItemName = newItemNameTextField.text, !newItemName.isEmpty {
            saveNewItemDelegate?.didSaveNewItem(newItem: Item(name: newItemName))
            newItemNameTextField.text = ""
            newItemNameTextField.resignFirstResponder()
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

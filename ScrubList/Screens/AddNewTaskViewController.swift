//
//  AddNewTaskViewController.swift
//  ScrubList
//
//  Created by Goyo Vargas on 8/20/22.
//

import UIKit

class AddNewTaskViewController: UIViewController {
    let textField = SLTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTextField()
        layoutUI()
        createDismissKeyboardTapGesture()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewTask))
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewTask))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureTextField() {
        textField.delegate = self
    }
    
    private func layoutUI() {
        view.addSubview(textField)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func saveNewTask() {
        print("Saving new task")
        dismiss(animated: true)
    }
    
    @objc private func cancelNewTask() {
        dismiss(animated: true)
    }
}

extension AddNewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

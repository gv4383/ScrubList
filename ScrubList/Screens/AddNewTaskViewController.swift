//
//  AddNewTaskViewController.swift
//  ScrubList
//
//  Created by Goyo Vargas on 8/20/22.
//

import UIKit

protocol AddNewTaskViewControllerDelegate: AnyObject {
    func didTapSave(_ newTask: String)
}

class AddNewTaskViewController: UIViewController {
    let textField = SLTextField()
    
    weak var delegate: AddNewTaskViewControllerDelegate?
    
    init(delegate: AddNewTaskViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func configureTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
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
        if let newTask = textField.text {
            delegate?.didTapSave(newTask)
        }
        
        dismiss(animated: true)
    }
    
    @objc private func cancelNewTask() {
        dismiss(animated: true)
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        guard let newTask = textField.text, !newTask.isEmpty else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

extension AddNewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

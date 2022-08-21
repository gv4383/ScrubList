//
//  SLTextField.swift
//  ScrubList
//
//  Created by Goyo Vargas on 8/21/22.
//

import UIKit

class SLTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        
        backgroundColor = .tertiarySystemBackground
        returnKeyType = .done
        placeholder = "Task name"
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
}

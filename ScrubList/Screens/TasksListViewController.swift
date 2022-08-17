//
//  TasksListViewController.swift
//  ScrubList
//
//  Created by Goyo Vargas on 8/17/22.
//

import UIKit

class TasksListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemPurple
        title = "Tasks"
    }
}

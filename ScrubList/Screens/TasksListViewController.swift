//
//  TasksListViewController.swift
//  ScrubList
//
//  Created by Goyo Vargas on 8/17/22.
//

import UIKit

class TasksListViewController: UIViewController {
    let tableView = UITableView()
    
    var tasks: [Task] = [
        Task(name: "Task 1"),
        Task(name: "Task 2"),
        Task(name: "Task 3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTableView()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Tasks"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TasksListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = UITableViewCell()
        
        cell.textLabel?.text = task.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

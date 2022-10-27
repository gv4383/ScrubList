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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func addButtonTapped() {
        let addNewTaskVC = AddNewTaskViewController(delegate: self)
        let navController = UINavigationController(rootViewController: addNewTaskVC)
        present(navController, animated: true)
    }
}

extension TasksListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = UITableViewCell()
        
        let attributeString = NSMutableAttributedString(string: task.name)
        let attributeStringRange = NSRange(location: 0, length: attributeString.length)
        
        if task.isChecked {
            attributeString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: 2,
                range: attributeStringRange
            )
        }
        
        cell.textLabel?.attributedText = attributeString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].isChecked.toggle()
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}

extension TasksListViewController: AddNewTaskViewControllerDelegate {
    func didTapSave(_ newTask: String) {
        let newTaskModel = Task(name: newTask)
        
        tasks.append(newTaskModel)
        tableView.reloadData()
    }
}

//
//  TaskStorage.swift
//  ScrubList
//
//  Created by Goyo Vargas on 10/27/22.
//

import Combine
import CoreData
import UIKit

final class TaskStorage: NSObject, ObservableObject {
    var tasks = CurrentValueSubject<[TaskEntity], Never>([])
    private let taskFetchController: NSFetchedResultsController<TaskEntity>
    private let context: NSManagedObjectContext
    static let shared = TaskStorage()
    
    private override init() {
        context = DataController.shared.container.viewContext
        
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        taskFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        
        do {
            tasks.value = taskFetchController.fetchedObjects ?? []
        }
    }
    
    func create(withName name: String) throws {
        let newTask = TaskEntity(context: context)
        newTask.id = UUID()
        newTask.isChecked = false
        newTask.name = name
        
        try saveTask()
    }
    
    func destroy(withId id: UUID) throws {
        let task = tasks.value.first { $0.id == id }!
        context.delete(task)
        
        try saveTask()
    }
    
    private func saveTask() throws {
        try context.save()
    }
}

extension TaskStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let tasks = controller.fetchedObjects as? [TaskEntity] else { return }
        print("Context has changed. Reloading tasks.")
        
        self.tasks.value = tasks
    }
}

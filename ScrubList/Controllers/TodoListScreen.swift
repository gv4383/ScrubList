//
//  TodoListScreen.swift
//  ScrubList
//
//  Created by Vargas, Greg on 12/29/20.
//

import UIKit

class TodoListScreen: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = createItemsArray()
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    func createItemsArray() -> [Item] {
        var tempItems: [Item] = []
        
        let item1 = Item(name: "First item")
        let item2 = Item(name: "Second item")
        let item3 = Item(name: "Third item")
        
        tempItems.append(item1)
        tempItems.append(item2)
        tempItems.append(item3)
        
        return tempItems
    }
    
    @IBAction func unwindToListScreen(_ unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.listToItemSegue, sender: self)
    }
    
    func removeItem(itemIndex: Int) {
        items.remove(at: itemIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.listToItemSegue {
            let destination = segue.destination as! NewListItemScreen
            destination.saveNewItemDelegate = self
        }
    }
}

extension TodoListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemCellIdentifier) as! ItemCell
        
        cell.setItem(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemCellIdentifier) as! ItemCell
        
        print(indexPath.row)
        cell.printName(item: item)
        
        removeItem(itemIndex: indexPath.row)
        tableView.reloadData()
    }
}

extension TodoListScreen: SaveNewItemDelegate {
    func didSaveNewItem(newItem: Item) {
        items.append(newItem)
        listTableView.beginUpdates()
        listTableView.insertRows(at: [IndexPath.init(row: self.items.count - 1, section: 0)], with: .automatic)
        listTableView.endUpdates()
    }
}

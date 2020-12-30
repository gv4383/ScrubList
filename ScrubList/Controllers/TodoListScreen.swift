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
}

extension TodoListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        cell.setItem(item: item)
        
        return cell
    }
}

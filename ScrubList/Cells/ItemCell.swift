//
//  ItemCell.swift
//  ScrubList
//
//  Created by Vargas, Greg on 12/29/20.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    
    func setItem(item: Item) {
        itemNameLabel.text = item.name
    }
    
    func printName(item: Item) {
        print(item.name)
    }
}

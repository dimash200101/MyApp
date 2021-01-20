//
//  TableViewCell.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var doneImage: UIImageView!
    @IBOutlet var deadlineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
    func configure(with item: ToDoItem) {
        titleLabel.text = item.title
        subTitleLabel.text = item.subtitle
        deadlineLabel.text = item.deadLine
        doneImage.image = item.status == ToDoItem.Status.done ? UIImage(named: "done")! : UIImage(named: "not-done")
    }
}

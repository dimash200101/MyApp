//
//  AddViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by Galym Anuarbek on 1/20/21.
//

import UIKit

protocol AddViewControllerDelegate {
    func didAddItem(_ item: ToDoItem)
    func didEditItem(_ item: ToDoItem, id: Int)
}

class AddViewController: UIViewController {

    var delegate: AddViewControllerDelegate?
    
    var item: ToDoItem?
    
    var id = 0
    var isAdding: Bool = true
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var subtitleField: UITextField!
    @IBOutlet var deadlineField: UITextField!
    @IBOutlet var statusSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let item = item else { return }
        titleField.text = item.title
        subtitleField.text = item.subtitle
        deadlineField.text = item.deadLine
        statusSwitch.setOn(item.status == ToDoItem.Status.done, animated: false)
    }
    
    @IBAction func addButtonHandler(_ sender: Any) {
        let item = ToDoItem(title: titleField.text ?? "",
                            subtitle: subtitleField.text ?? "",
                            deadLine: deadlineField.text ?? "",
                            status: ToDoItem.Status(rawValue: statusSwitch.isOn ? 0 : 1) ?? .done)
        isAdding ? delegate?.didAddItem(item) : delegate?.didEditItem(item, id: id)
        navigationController?.popViewController(animated: true)
    }
    
}

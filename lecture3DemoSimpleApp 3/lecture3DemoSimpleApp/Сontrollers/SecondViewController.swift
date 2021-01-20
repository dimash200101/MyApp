//
//  SecondViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [ToDoItem]()
    let cellId = "TableViewCell"
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
        testDataConfigure()
    }

    
    func testDataConfigure(){
        arr.append(ToDoItem(title: "first", subtitle: "sub", deadLine: "20.12.2021", status: .inProgress))
        arr.append(ToDoItem(title: "second", subtitle: "sub", deadLine: "22.12.2021", status: .inProgress))
        arr.append(ToDoItem(title: "third", subtitle: "sub", deadLine: "12.08.2021", status: .inProgress))
        arr.append(ToDoItem(title: "uno", subtitle: "sub", deadLine: "05.07.2021", status: .done))
        arr.append(ToDoItem(title: "dos", subtitle: "sub", deadLine: "29.12.2021", status: .done))
    }
    
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        //change this method
        //Alert manager with two fields
        let vc = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.delegate = self
        vc.isAdding = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func removeItem(_ id: Int) {
        //remove item from array
        arr.remove(at: id)
        tableView.reloadData()
    }
    
    func editItem(_ id: Int) {
        //open new view controller which allows you to change the data of the array item
        let vc = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.delegate = self
        vc.item = arr[id]
        vc.id = id
        vc.isAdding = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = arr[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            self.editItem(indexPath.row)
            completionHandler(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            self.removeItem(indexPath.row)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
}

extension SecondViewController: AddViewControllerDelegate {
    func didAddItem(_ item: ToDoItem) {
        arr.append(item)
        tableView.reloadData()
    }
    
    func didEditItem(_ item: ToDoItem, id: Int) {
        arr[id] = item
        tableView.reloadData()
    }
}

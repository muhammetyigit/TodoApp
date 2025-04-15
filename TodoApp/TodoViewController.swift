//
//  ViewController.swift
//  TodoApp
//
//  Created by Muhammet Yiğit on 15.04.2025.
//

import UIKit

class TodoViewController: UITableViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    var todos = [
        Todo(title: "Buy an apple, today"),
        Todo(title: "Do your homework math")
    ]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableView DataSource & Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        let todoItem = todos[indexPath.row].done
        
        cell.textLabel?.text = todos[indexPath.row].title
        cell.accessoryType = todoItem ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].done.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Functions
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert: UIAlertController = .init(title: "Add New Todo", message: "", preferredStyle: .alert)
        let action: UIAlertAction = .init(title: "Add Todo", style: .default) { action in
            if let text = textField.text {
                var newTodo = Todo()
                newTodo.title = text
                self.todos.append(newTodo)
                    self.tableView.reloadData()
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Todo"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


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
    let manager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Item.plist")
    var todos = [Todo]()
    var tableViewEditing = false
    var totalCheck = 0
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todos = loadTodos()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - TableView DataSource & Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        let todoItem = todos[indexPath.row].done
        
        
        cell.textLabel?.text = todos[indexPath.row].title
        if todoItem {
            cell.accessoryType = .checkmark
            totalCheck += 1
        } else {
            cell.accessoryType = .none
            totalCheck -= 1
        }
        
        saveTodo()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].done.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveTodo()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedTodo = todos.remove(at: sourceIndexPath.row)
        todos.insert(movedTodo, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    // MARK: - Functions
    func saveTodo() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(todos)
            try data.write(to: manager)
        } catch {
            print(error)
        }
    }
    
    func loadTodos() -> [Todo] {
        let decoder = PropertyListDecoder()
        
        if FileManager.default.fileExists(atPath: manager.path) {
            do {
                let data = try Data(contentsOf: manager)
                let todos = try decoder.decode([Todo].self, from: data)
                return todos
            } catch {
                print(error)
                return []
            }
        } else {
            return []
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert: UIAlertController = .init(title: "Add New Todo", message: "", preferredStyle: .alert)
        let action: UIAlertAction = .init(title: "Add Todo", style: .default) { action in
            if let text = textField.text {
                var newTodo = Todo()
                newTodo.title = text
                self.todos.append(newTodo)
                self.saveTodo()
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
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        tableViewEditing.toggle()
        tableView.setEditing(tableViewEditing, animated: true)
    }
}


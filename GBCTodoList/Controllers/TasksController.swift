//
//  TasksController.swift
//  GBCTodoList
//
//  Created by Igor Kenji Mori on 2019-03-14.
//  Copyright © 2019 Igor Kenji Mori. All rights reserved.
//

import UIKit


class TasksController: UITableViewController{
    // = optional value TaskStore()
    var taskStore : TaskStore!{
        didSet{
            //Get data
            taskStore.tasks = TasksUtility.fetch() ?? [[Task](),[Task]()]
            //Reload table
        }
    }
    
    // when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //add buttom
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        // Setting up our alert controller
        
        let alertControler = UIAlertController(title: "addTask", message: nil, preferredStyle: .alert)
        
        //set up the actions
        
        let addAction = UIAlertAction(title: "Add", style: .default){ _ in
            // Grab text field text
            guard let name = alertControler.textFields?.first?.text else {return}
            guard let date = alertControler.textFields?.last?.text else {return}
            
            // create task
            let newTask = Task(name: name, date: date)
            
            //add task
            self.taskStore.add(newTask,at:0)
            
            //reload data in table view
            let indexPath = IndexPath(row: 0, section:0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
                   
        }
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        //add the text field
        
        alertControler.addTextField{textField in
            textField.placeholder = "Enter your topic name ..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        alertControler.addTextField{textField in
            textField.placeholder = "Enter your Date ..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        
        //add the actions
        
        alertControler.addAction(addAction)
        alertControler.addAction(cancelAction)
        
        // Present
        
        present(alertControler,animated: true)
        
    }
    @objc private func handleTextChanged(_ sender: UITextField ){
        
        //Grab the alert controller and add action
        guard let alertController =  presentedViewController as? UIAlertController,
        let addAction = alertController.actions.first,
        let text = sender.text
        else { return }
        
        // Enable add action base on if text is empty or contains whitespaces
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
}


// MARK: - DataSource

extension TasksController{
    
   
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return  section == 0 ? "To-do" : "Done"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count // the number of sections thta we just add above
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskStore.tasks[section].count //number of data in each index
        
    }
    
 
    
    @available(iOS 2.0, *)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let labelName = UILabel()
        labelName.text = taskStore.tasks[indexPath.section][indexPath.row].name
        let labelDate = UILabel()
        labelDate.text = taskStore.tasks[indexPath.section][indexPath.row].date
        labelName.text = (labelName.text ?? "") + " " + (labelDate.text ?? "")
        
        cell.textLabel?.text = labelName.text // add the text to each row
        return cell
    }
}

// Mark: Delegate
extension TasksController{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil){( action, sourceView, completionHandler) in
        //determine wheter the task isNode
            guard let isDone = self.taskStore.tasks[indexPath.section][indexPath.row].isDone else{return}

        
        // remove the task from the appropriate array
            self.taskStore.removeTask(at: indexPath.row,isDone: isDone)
        //Reload table view
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
       
        //indicates that the action was performed
            completionHandler(true)
        }
        
        deleteAction.image = #imageLiteral(resourceName: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: nil){( action,sourceView,completionHandler) in
        
            //Toggle that the task is done
            self.taskStore.tasks[indexPath.section][indexPath.row].isDone = true
            
            // Remove the task ftrom the array containing todo task
            let doneTask = self.taskStore.removeTask(at: indexPath.row)
            
            //Reload table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //Add the task from the task containing done task
            self.taskStore.add(doneTask,at:0,isDone: true)
            
            //Reload table view
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)

            
            
            //Indicate the action was preformed
            completionHandler(true)
        
        }
        doneAction.image = #imageLiteral(resourceName: "done")
        doneAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
    }
    
}

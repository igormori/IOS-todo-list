//
//  editControllerViewController.swift
//  GBCTodoList
//
//  Created by Igor Kenji Mori on 2019-03-14.
//  Copyright © 2019 Igor Kenji Mori. All rights reserved.
//

import UIKit

class editControllerViewController: UIViewController {

    
    @IBOutlet weak var text: UITextField!
    var nameText = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func done(_ sender: Any) {
        nameText = text.text!
        performSegue(withIdentifier: "back", sender: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TasksController
//        var newTask = Task(name: nameText, date: "20/01/2019")
//        vc.todoTask.insert(newTask, at: 0)
    }
    
    

}

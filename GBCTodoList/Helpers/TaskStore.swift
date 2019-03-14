//
//  TaskStore.swift
//  GBCTodoList
//
//  Created by Igor Kenji Mori on 2019-03-14.
//  Copyright © 2019 Igor Kenji Mori. All rights reserved.
//

import Foundation


class TaskStore{
    
    var tasks = [[Task](),[Task]()]
                //todo      //done
    
    func add(_ task:Task , at index: Int, isDone:Bool = false){
        let section = isDone ? 1 : 0
        
        tasks[section].insert(task, at: index)
    }
    
  
    @discardableResult func removeTask(at index: Int, isDone: Bool = false)-> Task{
        let section = isDone ? 1 : 0
        
        return tasks[section].remove(at: index)
    }
}

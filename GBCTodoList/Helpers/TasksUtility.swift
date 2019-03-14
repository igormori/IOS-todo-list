//
//  TasksUtility.swift
//  GBCTodoList
//
//  Created by Igor Kenji Mori on 2019-03-14.
//  Copyright © 2019 Igor Kenji Mori. All rights reserved.
//

import Foundation


class TasksUtility{
    
    private static let key = "tasks"

    // archive
    
    private static func archive(_ tasks:[[Task]]) -> NSData{
        return NSKeyedArchiver.archivedData(withRootObject: tasks) as NSData
    }
    
    //fetch
    static func fetch() -> [[Task]]?{
        guard let unarchivedData = UserDefaults.standard.object(forKey: "tasks") as? Data else{ return nil}
        
        return NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as? [[Task]]
    }
    
    
    //save
    
    static func save(_ tasks: [[Task]]){
        
        //Archive
        let archivedTasks = archive(tasks)
        
        
        //Set Object for key
        UserDefaults.standard.set(archivedTasks,forKey: key)
        UserDefaults.standard.synchronize()
    }
}

//
//  Task.swift
//  GBCTodoList
//
//  Created by Igor Kenji Mori on 2019-03-14.
//  Copyright © 2019 Igor Kenji Mori. All rights reserved.
//

import Foundation

class Task: NSObject , NSCoding{
    
    var name:String?
    var isDone: Bool?
    var date: String?
    
    private let nameKey = "name"
    private let isDoneKey = "isDone"
    private let dateKey = "date"
    
    
    init(name:String,date:String ,isDone:Bool = false){
        self.name = name
        self.date = date
        self.isDone = isDone
    }
    
    func encode(with aCoder: NSCoder) {

        aCoder.encode(name,forKey:nameKey)
        aCoder.encode(isDone,forKey:isDoneKey)
        aCoder.encode(date,forKey:dateKey)
    }
    
    required init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
              let isDone = aDecoder.decodeObject(forKey: isDoneKey) as? Bool,
              let date = aDecoder.decodeObject(forKey: dateKey) as? String
            else{ return }
        
        self.name = name
        self.isDone = isDone
        self.date = date
    }
    
}

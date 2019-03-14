//
//  AppDelegate.swift
//  GBCTodoList
//
//  Created by Igor Kenji Mori on 2019-03-14.
//  Copyright © 2019 Igor Kenji Mori. All rights reserved.
//

import UIKit

extension UINavigationController{
    
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return  .lightContent
    }
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // Initialize taskStore
    let taskStore = TaskStore()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
     
        
//        let todoTasks = [Task.init(name: "meditate",date:"April 16,19 12:00pm"),Task.init(name: "meditate1",date:"April 16,19 12:00pm"),Task.init(name: "meditate2",date:"April 16,19 12:00pm")]
//        let doneTasks = [Task.init(name: "study",date:"April 16,19 12:00pm")]
//
//        taskStore.tasks = [todoTasks,doneTasks]
        
        //Grad the tasksController
        let tasksController = window?.rootViewController?.childViewControllers.first as? TasksController
        
        //Set the taskStore accoordingly
        tasksController?.taskStore = taskStore
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //save
        TasksUtility.save(self.taskStore.tasks)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        //save
        TasksUtility.save(self.taskStore.tasks)
    }


}


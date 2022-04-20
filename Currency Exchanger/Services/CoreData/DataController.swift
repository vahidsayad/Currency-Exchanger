//
//  DataController.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 18/4/2022 .
//

import CoreData

class DataController: ObservableObject {
    private init() {}
    static let shared = DataController()
    var errorHandler: (Error) -> Void = {_ in }
    
    internal lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                let errorInfo = error._userInfo ?? "Unknown Error" as AnyObject
                NSLog("CoreData error \(error), \(errorInfo)" )
                self?.errorHandler(error)
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return container.viewContext
    }()
    
    func performBackgroundSaveTask(_ block: @escaping (NSManagedObjectContext) -> Void, saveCompletion: ((_ text: String?)-> Void)?) {
        container.performBackgroundTask { (context: NSManagedObjectContext) in
            context.automaticallyMergesChangesFromParent = true
            context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            block(context)
            do {
                if context.hasChanges {
                    try context.save()
                    print("Context Saved")
                }
                DispatchQueue.main.async {
                    saveCompletion?(nil)
                }
            } catch let error {
                print("Context Saved: [Error]")
                DispatchQueue.main.async {
                    saveCompletion?(error.localizedDescription)
                }
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error in saving context")
            }
        }
    }
}

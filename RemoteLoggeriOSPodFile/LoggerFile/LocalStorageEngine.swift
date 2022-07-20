//
//  LocalStorageEngine.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 06/07/22.
//

import UIKit
import RealmSwift

class LocalStorageEngine: NSObject {
    
    static let shared = LocalStorageEngine()
    
    //MARK:- Save RemoteLoggerInfo Locally
    func saveRemoteLoggerLocally(companyCodes: LoggerCode, failure: @escaping
        ((Bool) -> ()), completion: @escaping ((Bool) -> ())) {
        DispatchQueue.main.async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(companyCodes)
                }
                print("Realm Path : \(String(describing: realm.configuration.fileURL?.absoluteURL))")
                completion(true)
            } catch {
                failure(true)
                debugPrint("error caught whle writing to realm")
            }
        }
    }
    
    //MARK:- Get RemoteLoggerInfo
    func getLocalRemoteLogger() -> [LoggerCode?] {
        do {
            let realm = try Realm()
            let result = realm.objects(LoggerCode.self)
            return result.toArray()
        } catch {
            debugPrint("error caught whle writing to realm")
        }
        return [LoggerCode()]
    }
    
    //MARK:- Delete Local RemoteLoggerInfo
    func deleteRemoteLoggerInfo(with loggerDateId: String) -> Bool {
        do {
            let realm = try Realm()
            let objToDelete = realm.objects(LoggerCode.self).filter("loggerDateId == %@", loggerDateId)
            
            try realm.write {
                realm.delete(objToDelete)
            }
            return true
        } catch {
            debugPrint("error caught whle writing to realm")
        }
        return false
    }
}




extension Results {
    func toArray() -> [Element] {
        let result = List<Element>()
        
        forEach {
            result.append($0)
        }
        
        return Array(result.detached())
    }
}

extension List: DetachableObject {
    func detached() -> List<Element> {
        let result = List<Element>()
        
        forEach {
            if let detachable = $0 as? DetachableObject {
                let detached = detachable.detached() as! Element
                result.append(detached)
            } else {
                result.append($0) //Primtives are pass by value; don't need to recreate
            }
        }
        
        return result
    }
    
    func toArray() -> [Element] {
        return Array(self.detached())
    }
}

protocol DetachableObject: AnyObject {
    func detached() -> Self
}

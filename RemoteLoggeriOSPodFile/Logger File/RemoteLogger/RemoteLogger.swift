//
//  RemoteLogger.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 06/07/22.
//

import Foundation
import UIKit

public class RemoteLogger {
    
    public class func setTag(_ tag: String)  {
        print("tag: ", tag)
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLogger.setLocalDataInRealm(withTag: tag)
            } else {
                print("Please register your app")
            }
        }
    }
    
    public class func setLevel(_ level: String)  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLogger.setLocalDataInRealm(level: level)
            } else {
                print("Please register your app")
            }
        }
        print("level: ", level)
    }
    
    public class func log(_ desc: String, tag: String = "")  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLogger.setLocalDataInRealm(withTag: tag, desc: desc)
            } else {
                print("Please register your app")
            }
        }
        print("desc: ", desc, "  tag: ", tag)
    }
    
    public class func register(_ register: String)  {
        DispatchQueue.main.async {
            if !register.isEmpty {
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.isUserRegister.rawValue)
                UserDefaults.standard.set(register, forKey: UserDefaultKeys.userRegisterValue.rawValue)
            } else {
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.isUserRegister.rawValue)
                UserDefaults.standard.set("", forKey: UserDefaultKeys.userRegisterValue.rawValue)
            }
        }
        print("register: ", register)
    }
    
    private class func setLocalDataInRealm(withTag tag: String = "", desc: String = "", level: String = "") {
        let loggerCodeObject = LoggerCode()
        loggerCodeObject.loggerTag = tag
        loggerCodeObject.loggerDesc = desc
        loggerCodeObject.loggerSetLevel = level
        LocalStorageEngine.shared.saveRemoteLoggerLocally(companyCodes: loggerCodeObject) { isFailed in
            print("isFailed: ", isFailed)
        } completion: { isSucess in
            DispatchQueue.main.async {
                RemoteLogger.addLocalDataBaseCallApi()
            }
            print("isSucess: ", isSucess)
        }
    }
    
    private class func addLocalDataBaseCallApi() {
        let arrData = LocalStorageEngine.shared.getLocalRemoteLogger()
        if Reachability.isConnectedToNetwork() {
            if !arrData.isEmpty {
                for localObject in arrData {
                    if let object = localObject {
                        let requestLogModel = RequestLogModel(level: object.loggerSetLevel, tag: object.loggerTag, description: object.loggerDesc)
                        ApiCall.shared.callSaveLogApi(dict: requestLogModel.toDataDict(), loggerDateId: object.loggerDateId)
                    }
                }
            }
        }
    }
}



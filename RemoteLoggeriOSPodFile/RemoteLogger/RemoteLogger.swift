//
//  RemoteLogger.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 06/07/22.
//

import Foundation

public class RemoteLogger {
    
    public class func setTag(_ tag: String)  {
        print("tag: ", tag)
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                let requestLogModel = RequestLogModel(level: "", tag: tag, description: "")
                ApiCall.shared.callSaveLogApi(dict: requestLogModel.toDataDict())
                
            } else {
                print("Please register your app")
            }
        }
    }
    
    public class func setLevel(_ level: String)  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                let requestLogModel = RequestLogModel(level: level, tag: "", description: "")
                ApiCall.shared.callSaveLogApi(dict: requestLogModel.toDataDict())
            } else {
                print("Please register your app")
            }
        }
        print("level: ", level)
    }
    
    public class func log(_ desc: String, tag: String? = "")  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                let requestLogModel = RequestLogModel(level: "", tag: tag, description: desc)
                ApiCall.shared.callSaveLogApi(dict: requestLogModel.toDataDict())
            } else {
                print("Please register your app")
            }
        }
        print("desc: ", desc, "  tag: ", tag ?? "")
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
}



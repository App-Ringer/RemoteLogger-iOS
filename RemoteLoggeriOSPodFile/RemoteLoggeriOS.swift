//
//  RemoteLoggeriOS.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 06/07/22.
//

import Foundation
import UIKit

public class RemoteLoggeriOS {
    
    public class func setTag(_ tag: String)  {
        print("tag: ", tag)
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLoggeriOS.setLocalDataInRealm(withTag: tag)
            } else {
                print("API key is missing")
            }
        }
    }
    
    public class func setLevel(_ level: String)  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLoggeriOS.setLocalDataInRealm(level: level)
            } else {
                print("API key is missing")
            }
        }
    }
    
    public class func log(_ desc: String, tag: String = "", json: [String:Any] = [:])  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLoggeriOS.setLocalDataInRealm(withTag: tag, desc: desc, json: json)
                //(withTag: tag, desc: desc)
            } else {
                print("API key is missing")
            }
        }
    }
    
    public class func debug(_ desc: String, tag: String = "", json: [String:Any] = [:])  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLoggeriOS.setLocalDataInRealm(withTag: tag, desc: desc, level: "debug", json: json)
            } else {
                print("API key is missing")
            }
        }
    }
    
    public class func info(_ desc: String, tag: String = "", json: [String:Any] = [:])  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLoggeriOS.setLocalDataInRealm(withTag: tag, desc: desc, level: "info", json: json)
            } else {
                print("API key is missing")
            }
        }
    }
    
    public class func error(_ desc: String, tag: String = "", json: [String:Any] = [:])  {
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: UserDefaultKeys.isUserRegister.rawValue) {
                RemoteLoggeriOS.setLocalDataInRealm(withTag: tag, desc: desc, level: "error", json: json)
            } else {
                print("API key is missing")
            }
        }
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
    }
    
    private class func setLocalDataInRealm(withTag tag: String = "", desc: String = "", level: String = "", json: [String:Any] = [:]) {
        let loggerCodeObject = LoggerCode()
        loggerCodeObject.loggerTag = tag
        loggerCodeObject.loggerDesc = desc
        loggerCodeObject.loggerSetLevel = level
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                loggerCodeObject.loggerJsonString = jsonString
            }
        }
        LocalStorageEngine.shared.saveRemoteLoggerLocally(companyCodes: loggerCodeObject) { isFailed in
            print("isFailed: ", isFailed)
        } completion: { isSucess in
            DispatchQueue.main.async {
                RemoteLoggeriOS.addLocalDataBaseCallApi()
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
                        let requestLogModel = RequestLogModel(level: object.loggerSetLevel, tag: object.loggerTag, description: object.loggerDesc, jsonString: object.loggerJsonString)
                        ApiCall.shared.callSaveLogApi(dict: requestLogModel.toDataDict(), loggerDateId: object.loggerDateId)
                    }
                }
            }
        }
    }
}



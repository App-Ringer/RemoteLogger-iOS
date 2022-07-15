//
//  RequestLogModel.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 07/07/22.
//

import Foundation
import UIKit
import RealmSwift

struct RequestLogModel: Codable {
    
    var level: String?
    var tag: String?
    var description: String?
    var jsonString: String?
    
    func toDataDict() -> [String: Any] {
        var userdata: [String: Any] = [
            "level": level ?? "",
            "tag": tag ?? "",
            "description": description ?? ""
        ]

        let deviceInfo: [String: Any] = [
            "ios": UIDevice.current.systemVersion,
            "platform": UIDevice().type.rawValue,
        ]
        userdata["device_info"] = deviceInfo
        userdata["json"] = [:]
        if let data = jsonString?.data(using: .utf8) {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                userdata["json"] = json
            }
        }
        print("json: ", userdata)
        return userdata
    }
}

class LoggerCode: Object {
    @objc dynamic var loggerDateId = "loggerDate_\(Date().ticks)"
    @objc dynamic var loggerTag = ""
    @objc dynamic var loggerSetLevel = ""
    @objc dynamic var loggerDesc = ""
    @objc dynamic var loggerLog = ""
    @objc dynamic var loggerJsonString = ""

}

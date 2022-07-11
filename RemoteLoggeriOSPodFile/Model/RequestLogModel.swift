//
//  RequestLogModel.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 07/07/22.
//

import Foundation
import UIKit

struct RequestLogModel: Codable {
    
    var level: String?
    var tag: String?
    var description: String?
    
    func toDataDict() -> [String: Any] {
//        var dataDic = [String: Any]()
        var userdata: [String: Any] = [
            "level": level ?? "",
            "tag": tag ?? "",
            "description": description ?? ""
        ]

        let jsonInfo: [String: Any] = [:]
        let deviceInfo: [String: Any] = [
            "ios": UIDevice.current.systemVersion,
            "platform": UIDevice().type.rawValue,
        ]
        userdata["device_info"] = deviceInfo
        userdata["json"] = jsonInfo
       // dataDic = userdata
        print("json: ", userdata)
        return userdata
    }
}

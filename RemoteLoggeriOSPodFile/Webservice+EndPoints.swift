//
//  Webservice+EndPoints.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 07/07/22.
//

import Foundation

let baseUrl =  "https://logs.appringer.in/api/"

enum EndPoint : String {
    case log = "log"
}

enum UserDefaultKeys: String {
    case isUserRegister                                                 = "IsUserRegister"
    case userRegisterValue                                              = "UserRegisterValue"

}

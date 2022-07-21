//
//  ApiCall.swift
//  RemoteLoggerFramework
//
//  Created by iMac on 07/07/22.
//

import Foundation

class ApiCall {
    static let shared = ApiCall()
    
    func callSaveLogApi(dict: [String: Any], loggerDateId: String) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let userRegisterKey = UserDefaults.standard.string(forKey: UserDefaultKeys.userRegisterValue.rawValue) {
                    print("parameters: ", jsonString)
                    let postData = jsonString.data(using: .utf8)
                    var request = URLRequest(url: URL(string: "\(baseUrl)\(EndPoint.log.rawValue)")!,timeoutInterval: Double.infinity)
                    
                    request.addValue(userRegisterKey, forHTTPHeaderField: "x-api-key")
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    request.httpMethod = "POST"
                    request.httpBody = postData
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data else {
                            print(String(describing: error))
                            return
                        }
                        if let dictData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let code = dictData["code"] as? Int, code == 200 {
                                let isSucess = LocalStorageEngine.shared.deleteRemoteLoggerInfo(with: loggerDateId)
                                print("Delete Local Data: ", isSucess)
                            }
                        }
                        print(String(data: data, encoding: .utf8)!)
                    }
                    task.resume()
                } else {
                    print("RemoteLoggeriOS    =======    API key is missing   =======")
                }
            }
        }
    }
}

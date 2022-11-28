//
//  LoginViewModel.swift
//  Swifty Twitter
//
//  Created by Jeet Dholakia on 27/11/22.
//

import Foundation
import Alamofire

struct LoginViewModel {
    init() {
        let params: Parameters = [
                "email": "jeetx@jeet.com",
                "password": "12345678",
                "age": "23"
            ]
        AF.request("\(Constants.baseURL)/auth", method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            print(response)
            switch response.result {
                        case .success(let data):
                            do {
                                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                                    print("Error: Cannot convert data to JSON object")
                                    return
                                }
                                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                                    print("Error: Cannot convert JSON object to Pretty JSON data")
                                    return
                                }
                                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                                    print("Error: Could print JSON in String")
                                    return
                                }
                        
                                print(prettyPrintedJson)
                            } catch {
                                print("Error: Trying to convert JSON data to string")
                                return
                            }
                        case .failure(let error):
                            print(error)
                    }
        }
    }
}

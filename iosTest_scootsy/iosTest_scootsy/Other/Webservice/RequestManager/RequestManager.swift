//
//  RequestManager.swift
//  iosTest_scootsy
//
//  Created by vivek G on 12/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit

class RequestManager: NSObject {
    
    //MARK: - api call for get- post- put- apis
    /// common method is used for "Get" type of request
    ///
    /// - Parameters:
    ///   - strAPIName: api name (procedure name)
    ///   - strParameterName: param (always be empty)
    ///   - completion: return type
    func requestCommonApiMethodCall_WithParam(strAPIName :String ,strMethodType:String,strParameterName : [String:Any] ,strHeaderToken : String  = ""  ,completion:@escaping (_ response: [String:Any],_ completed:Bool,_ errorMessage : String)->Void)  {
        let url : String = strAPIName// "\(MMUrlConstants.CommonUrl)\(strAPIName)"
        
        //let headers = strHeader
        let headers = [
            "Content-Type": "application/json",
            "cache-control": "no-cache",
            ]
        
        do{
            let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 60.0)
            if strMethodType == "GET"
            {
                request.httpMethod = "GET"
            }
            else
            {
                request.httpMethod = (strMethodType == "POST" ? "POST" : "PUT")
            }
            
            request.allHTTPHeaderFields = headers
            
            if strMethodType == "POST" || strMethodType == "PUT" {
                let postData = try JSONSerialization.data(withJSONObject: strParameterName, options: [])
                request.httpBody = postData as Data
            }
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    completion(["":""],false,error as? String ?? Constants.apologiesMessage )
                } else {
                    DispatchQueue.main.async {
                        let httpResponse = response as! HTTPURLResponse
                        let statusCode = httpResponse.statusCode
                  
                            if (statusCode == 200) {
                                guard let data = data else { return }
                                do {
                                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? Any else
                                    {
                                        return
                                    }
                                    
                                    if let code = json as? Array<Any> //Check for the array data
                                    {
                                        let dictata : [String: Any] = ["data" : code]
                                        completion(dictata,true, Constants.apologiesMessage)
                                    }
                                    else if let jsonData = json as? [String:Any] //Check for the code tag
                                    {
                                        if let status = jsonData["response"] as? [String:Any]
                                        {
                                            if let code = status["code"] as? String, code == "200"
                                            {
                                                completion(jsonData,true, Constants.apologiesMessage)
                                            }
                                            else
                                            {
                                                completion(["":""],false, Constants.apologiesMessage)//return failure
                                            }
                                        }
                                        else
                                        {
                                            completion(["":""],false, Constants.apologiesMessage)//return failure
                                        }
                                    }
                                    else
                                    {
                                        completion(["":""],true, Constants.apologiesMessage)
                                    }
                                    
                                } catch let jsonErr {
                                    print("Error serializing json:", jsonErr)//No Value in JSON
                                    completion(["":""],true,error as? String ?? Constants.apologiesMessage )
                                }
                            }
                            else if(statusCode == 400)
                            {
                                completion(["":""],false,error as? String ?? Constants.apologiesMessage )
                            }
                            else
                            {
                                completion(["":""],false,error as? String ?? Constants.apologiesMessage)
                        }
                    }
                }
            })
            dataTask.resume()
        }catch {
            print("Error with Json: \(error)")
            completion(["":""],false,error as? String ?? Constants.apologiesMessage)
        }
    }
}

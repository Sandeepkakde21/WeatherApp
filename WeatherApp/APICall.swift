//
//  APICall.swift
//  WeatherApp
//
//  Created by Sandeep on 08/10/17.
//  Copyright © 2017 Green Leaves. All rights reserved.
//

import UIKit
typealias CompletionHandler = (_ success:Bool, _ serverResponse:NSString?, _ errorApi:Error?) -> Void

class APICall: NSObject {
    
    // MARK: Private function for Server connection
    private func getSharedSession() ->URLSession {
        let sessionConfiguration = URLSessionConfiguration.default as URLSessionConfiguration
        sessionConfiguration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let urlsession = URLSession(configuration: sessionConfiguration)
        return urlsession
    }
    
    private func apiCall(Request request:URLRequest, CompletionBlock completionhandler:@escaping CompletionHandler ){
        let dataTask = getSharedSession().dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil && data != nil {
                    //Convert file into Human readable format
                    if let fileContents = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                        completionhandler(true, fileContents, error)
                    }
                    completionhandler(false, nil, error)
                    
                }else {
                    print(error?.localizedDescription ?? "Error in while server communication")
                    completionhandler(false, nil, error)
                }
            }
        }
        dataTask.resume()
    }
    
    private func buildRequest(ApiUrl apiurl:NSString)-> URLRequest {
        var urlRequest = URLRequest(url: URL(string: apiurl as String)!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    // MARK: Public function for Server connection
    public func getFileData(Filepath fileUrl:NSString,CompletionBlock completionhandler:@escaping CompletionHandler) {
        self.apiCall(Request: self.buildRequest(ApiUrl: fileUrl)) { (suceess, fileData, error) in
            if error == nil {
                completionhandler(true, fileData, error)
            }else {
                completionhandler(false, nil, error)
            }
        }
    }
}

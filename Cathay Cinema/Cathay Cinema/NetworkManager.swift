//
//  NetworkManager.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum NetworkRequestType {
    case getMovies
}

typealias MoviesListCompletionHandler = (Bool,MoviesListResponse?,String?) -> ()
typealias MovieDetailCompletionHandler = (Bool,MovieDetail?,String?) -> ()


class NetworkManager {
    
    init() {
        
    }
    
    var header:[String:String] {
        get {
            return ["content-type": "application/json;charset=utf-8"]
        }
    }
 
    func getMoviesList(forPage page:Int,sortBy:String, completionHandler:@escaping MoviesListCompletionHandler) {
        
        let url = Constant.URL.baseUrl + Constant.URL.movieList
        
        let parameters = ["page":page.description,"sort_by":sortBy, "api_key":Constant.PrivateKey.restAPI]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: self.header).validate().responseObject { (response:DataResponse<MoviesListResponse>) in
            
            DispatchQueue.main.async {
                
                switch(response.result) {
                case .success:
                    if let moviesListResponse = response.result.value {
                        completionHandler(true,moviesListResponse,nil)
                    }
                    break
                    
                case .failure:
                    completionHandler(false,nil,response.error?.localizedDescription)
                    break
                }
            }
        }
    }

    
    func getMovieDetail(forMovie id:Int, completionHandler:@escaping MovieDetailCompletionHandler) {
        
        let url = Constant.URL.baseUrl + Constant.URL.movieDetail + "/\(String(id))"
        
        let parameters = ["api_key":Constant.PrivateKey.restAPI]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: self.header).validate().responseObject { (response:DataResponse<MovieDetail>) in
            
            DispatchQueue.main.async {
                
                switch(response.result) {
                case .success:
                    if let moviesDetailResponse = response.result.value {
                        completionHandler(true,moviesDetailResponse,nil)
                    }
                    break
                    
                case .failure:
                    completionHandler(false,nil,response.error?.localizedDescription)
                    break
                }
            }
        }
    }

}
  

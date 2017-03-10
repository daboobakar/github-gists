//
//  GistRouter.swift
//  githubGists
//
//  Created by Danyal Aboobakar on 09/03/2017.
//  Copyright © 2017 Danyal Aboobakar. All rights reserved.
//

import Foundation
import Alamofire

enum GistRouter: URLRequestConvertible {
    static let baseURLString = "https://api.github.com/"
    
    case getPublic()
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
        switch self {
        case .getPublic:
            return .get
            
            }
        }
        let url: URL = {
            let relativePath: String
            switch self {
            case .getPublic():
                relativePath = "/api/v1/11831/json"
            }
            
            var url = URL(string: GistRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getPublic:
            return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
    
    
    
}
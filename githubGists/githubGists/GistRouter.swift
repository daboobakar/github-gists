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
    case getAtPath(String)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
        switch self {
        case .getPublic, .getAtPath:
            return .get
            
            }
        }
        let url: URL = {
            let relativePath: String
            switch self {
            case .getAtPath(let path):
                // already have the full URL, so just return it
                return URL(string: path)!
            case .getPublic():
                relativePath = "gists/public"
            }
            
            var url = URL(string: GistRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getPublic, .getAtPath:
            return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}

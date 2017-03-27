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
    case getMyStarred()
    case getAtPath(String)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
        switch self {
        case .getPublic, .getAtPath, .getMyStarred():
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
            case .getMyStarred():
                relativePath = "gists/starred"
            }
            
            var url = URL(string: GistRouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getPublic, .getMyStarred, .getAtPath:
            return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let username = "daboobakar"
        let password = "password"
        
        
        if let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8) {
            let base64Credentials = credentialData.base64EncodedString()
            urlRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        }
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}

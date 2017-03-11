//
//  GitHubAPIManager.swift
//  githubGists
//
//  Created by Danyal Aboobakar on 09/03/2017.
//  Copyright © 2017 Danyal Aboobakar. All rights reserved.
//

import Foundation
import Alamofire

class GithubAPIManager {
    
    static let sharedInstance = GithubAPIManager()
    
    func printPublicGists() -> Void {
        Alamofire.request(GistRouter.getPublic())
            .responseString { response in
                if let receivedString = response.result.value {
                    print(receivedString)
                }
        }
    }
    
}

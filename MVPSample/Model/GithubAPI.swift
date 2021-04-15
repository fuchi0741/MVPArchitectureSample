//
//  GithubAPI.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import Foundation

enum GithubError: Error {
    case error
}

protocol GithubAPIProtocol {
    func get(searchWord: String, completion: ((Result<[GithubModel], GithubError>) -> Void)?)
}

final class GithubAPI: GithubAPIProtocol {
    static let shared = GithubAPI()
    private init() {}
    
    //TODO
    func get(searchWord: String, completion: ((Result<[GithubModel], GithubError>) -> Void)?) {
        guard searchWord.count > 0 else {
            completion?(.failure(.error))
            return
        }
        
        let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //早期リターン
            guard let data = data,
                  let githubResponse: GithubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
                  let models = githubResponse.items else {
                completion?(.failure(.error))
                return
            }
            
            completion?(.success(models))
        }
        
        task.resume()
    }
}

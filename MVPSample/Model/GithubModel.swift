//
//  GithubModel.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import Foundation

struct GithubResponse: Codable {
    let items: [GithubModel]?
}

struct GithubModel: Codable {
    let fullName: String
    var urlStr: String {
        return "https://github.com/\(fullName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}

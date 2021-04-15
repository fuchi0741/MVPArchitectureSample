//
//  MVPSearchPresenter.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import Foundation

protocol MVPSearchPresenterInput {
    
}

protocol MVPSearchPresenterOutput: AnyObject {
   
}

final class MVPSearchPresenter {
    
    private weak var output: MVPSearchPresenterOutput!
    
    private var api: GithubAPIProtocol!
    
    private var githubModels: [GithubModel]
    
    // TODO
    init(output: MVPSearchPresenterOutput, api: GithubAPIProtocol = GithubAPI.shared) {
        self.output = output
        self.api = api
        self.githubModels = []
    }
}

extension MVPSearchPresenter: MVPSearchPresenterInput {
    
}

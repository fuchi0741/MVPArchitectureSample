//
//  MVPSearchPresenter.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import Foundation

protocol MVPSearchPresenterInput {
    var numberOfItems: Int { get }
    func item(index: Int) -> GithubModel
    func searchText(_ text: String?)
    func didSelect(index: Int)
}

protocol MVPSearchPresenterOutput: AnyObject {
    func update(loading: Bool)
    func update(githubModels: [GithubModel])
    func get(error: Error)
    func showWeb(githubModel: GithubModel)
}

final class MVPSearchPresenter {
    
    private weak var output: MVPSearchPresenterOutput!
    
    private var api: GithubAPIProtocol
    
    private var githubModels: [GithubModel]
    
    // TODO
    init(output: MVPSearchPresenterOutput, api: GithubAPIProtocol = GithubAPI.shared) {
        self.output = output
        self.api = api
        self.githubModels = []
    }
}

extension MVPSearchPresenter: MVPSearchPresenterInput {
    var numberOfItems: Int {
        return githubModels.count
    }
    
    func item(index: Int) -> GithubModel {
        return githubModels[index]
    }
    
    func searchText(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        
        //loadingが始まったかを知らせる(PresenterはどんなUIかは興味ない。つまりこのflagがどのように使用されているかわからない)
        output.update(loading: true)
        self.api.get(searchWord: text) { (result) in
            self.output.update(loading: false)
            switch result {
            case .success(let githubModels):
                self.githubModels = githubModels
                self.output.update(githubModels: githubModels)
            case .failure(let error):
                self.output.get(error: error)
            }
        }
    }
    
    func didSelect(index: Int) {
        output.showWeb(githubModel: githubModels[index])
    }
}

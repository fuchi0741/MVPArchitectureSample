//
//  WebPresenter.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import Foundation

protocol WebPresenterInput {
    func viewDidLoaded()
}

protocol WebPresenterOutput: AnyObject {
    func load(urlRequest: URLRequest)
}

final class WebPresenter {
    
    //外へ出すprotocolに準拠したインスタンス(ほとんどの場合ViewControllerのこと)
    private weak var output: WebPresenterOutput!
    //初期化パラメータ
    private var githubModel: GithubModel
    
    init(output: WebPresenterOutput, githubModel: GithubModel) {
        self.output = output
        self.githubModel = githubModel
    }
}

extension WebPresenter: WebPresenterInput {
    func viewDidLoaded() {
        guard let url = URL(string: githubModel.urlStr) else { return }
        self.output.load(urlRequest: URLRequest(url: url))
    }
}


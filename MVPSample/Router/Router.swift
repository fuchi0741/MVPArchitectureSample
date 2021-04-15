//
//  Router.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import UIKit

final class Router {
    static let shared = Router()
    private init() { }
    
    private var window: UIWindow?
    
    func showRoot(window: UIWindow) {
        guard let vc = UIStoryboard.init(name: "MVPSearch", bundle: nil).instantiateInitialViewController() as? MVPSearchViewController else {
            return
        }
        
        //PresenterとVC同士を繋ぎ合う
        let presenter = MVPSearchPresenter(output: vc)
        vc.inject(presenter: presenter)
        
        
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}

//
//  WebViewController.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    private var presenter: WebPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoaded()
    }
    
    func inject(presenter: WebPresenterInput) {
        self.presenter = presenter
    }
}

extension WebViewController: WebPresenterOutput {
    func load(urlRequest: URLRequest) {
        self.webView.load(urlRequest)
    }
}

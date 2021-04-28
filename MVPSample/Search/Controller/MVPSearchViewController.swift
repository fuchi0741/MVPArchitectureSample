//
//  MVPSearchViewController.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import UIKit

class MVPSearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_sender:)), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: MVPTableViewCell.className, bundle: nil), forCellReuseIdentifier: MVPTableViewCell.className)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var presenter: MVPSearchPresenterInput!
    
    func inject(presenter: MVPSearchPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        indicator.isHidden = true
    }
    
    @objc
    func tapSearchButton(_sender: UIResponder) {
        //Presenterに処理を任せる(VCはどうやって検索するかわからない)
        self.presenter.searchText(searchTextField.text)
    }
}


extension MVPSearchViewController: MVPSearchPresenterOutput {
    func update(loading: Bool) {
        DispatchQueue.main.async {
            self.tableView.isHidden = loading
            self.indicator.isHidden = !loading
        }
    }
    
    func update(githubModels: [GithubModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func get(error: Error) {
        DispatchQueue.main.async {
            print(error.localizedDescription)
        }
    }
    
    func showWeb(githubModel: GithubModel) {
        DispatchQueue.main.async {
            Router.shared.showWeb(from: self, githubModel: githubModel)
        }
    }
}



extension MVPSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MVPTableViewCell.className) as? MVPTableViewCell else {
            fatalError()
        }
        
        let githubModel = presenter.item(index: indexPath.item)
        cell.configure(githubModel: githubModel)
        return cell
    }
}

extension MVPSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(index: indexPath.row)
    }
}

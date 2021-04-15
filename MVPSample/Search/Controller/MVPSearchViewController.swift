//
//  MVPSearchViewController.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import UIKit

class MVPSearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    
    private var presenter: MVPSearchPresenterInput!
    
    func inject(presenter: MVPSearchPresenterInput) {
        self.presenter = presenter
    }
    
    
    
    
}


extension MVPSearchViewController: MVPSearchPresenterOutput {
   
}

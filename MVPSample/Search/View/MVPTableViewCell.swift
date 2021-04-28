//
//  MVPTableViewCell.swift
//  MVPSample
//
//  Created by 渕一真 on 2021/04/15.
//

import UIKit

class MVPTableViewCell: UITableViewCell {
    
    static var className: String {
        String(describing: MVPTableViewCell.self)
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        urlLabel.text = nil
    }
    
    func configure(githubModel: GithubModel) {
        self.titleLabel.text = githubModel.fullName
        self.urlLabel.text = githubModel.urlStr
    }
}

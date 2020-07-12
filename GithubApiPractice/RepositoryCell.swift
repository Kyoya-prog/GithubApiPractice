//
//  RepositoryCell.swift
//  GithubApiPractice
//
//  Created by 松山響也 on 2020/07/10.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var RepositoryNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    var repositoryURL:URL!
    override func awakeFromNib() {
        super.awakeFromNib()
        RepositoryNameLabel.text = ""
        userNameLabel.text = ""
        repositoryURL = URL(string: "")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(repository:RepositoryModel.Repo){
        RepositoryNameLabel.text = repository.name
        userNameLabel.text = repository.fullName
        repositoryURL = URL(string: repository.htmlURL)
    }
    
}

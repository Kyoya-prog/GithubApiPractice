//
//  RepositoryCell.swift
//  GithubApiPractice
//
//  Created by 松山響也 on 2020/07/10.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

 
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBOutlet weak var markOfDescription: UILabel!
    var repositoryURL:URL!
    override func awakeFromNib() {
        super.awakeFromNib()
        repositoryNameLabel.text = ""
        descriptionLabel.text = ""
        repositoryURL = URL(string: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(repository:RepositoryModel.Repo){
        repositoryNameLabel.text = repository.fullName
        descriptionLabel.text = repository.description
        repositoryURL = URL(string: repository.htmlURL)
    }
    
}

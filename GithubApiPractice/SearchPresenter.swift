//
//  SearchPresenter.swift
//  GithubApiPractice
//
//  Created by 松山響也 on 2020/07/10.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import Foundation

public protocol SearchViewInput:class{
    func didTappedSearchButton(searchText:String)
    func getRepositoryCount()->Int
    func getRepositoryForRowAt(indexPath:Int)->RepositoryModel.Repo
    func didSelectRow(indexPath:IndexPath)
    
}
public protocol SearchViewOutput:class{
    
    func didLoadRepositories()
    func toDetailOfSelectedCell(url:URL)
    
}

class SearchPresenter:SearchViewInput{
    func didSelectRow(indexPath:IndexPath) {
        let url = URL(string:getRepositoryForRowAt(indexPath: indexPath.row).htmlURL)
        view.toDetailOfSelectedCell(url:url!)
    }
    
    func getRepositoryCount() -> Int {
        let count = model.numberRepositories()
        return count
    }
    
    weak var view:SearchViewController!
    var model:SearchModelInput!
    func didTappedSearchButton(searchText: String) {
        model.searchRepository(query: searchText) {
            do{
                if self.model.checkEmpty(){
                    throw SearchError.emptyResult
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.view.showEmptyResultAlert()
                }
            }
            self.view.didLoadRepositories()

        }
    }
    
    init (view:SearchViewController,model:SearchModelInput){
           self.view = view
           self.model = model
       }
    
    func getRepositoryForRowAt(indexPath: Int) -> RepositoryModel.Repo {
        let repository = model.RepositoryForRowAt(IndexPath:indexPath)
        return repository
    }
    
}

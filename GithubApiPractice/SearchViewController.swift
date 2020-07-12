//
//  ViewController.swift
//  GithubApiPractice
//
//  Created by 松山響也 on 2020/07/10.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import UIKit
import WebKit


class SearchViewController: UIViewController{

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    var presenter:SearchViewInput!
    var webView: WKWebView!
    public override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        initPresenter()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        
    }
    
    func initLayout(){
        
        searchTextField.frame = CGRect(x: 20, y: tableView.frame.minY - view.frame.height / 15, width: view.frame.width / 1.5, height: 40)
        searchButton.setTitle("検索", for: .normal)
        searchButton.frame = CGRect(x: searchTextField.frame.maxX, y: tableView.frame.minY - view.frame.height / 15 , width: 100, height: 40)
        searchButton.backgroundColor = .cyan
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 20.0
        tableView.frame = CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.height / 4 * 3)
        
       
        
        
    }
    func initPresenter(){
         let model = SearchModel()
        self.presenter = SearchPresenter(view:self,model:model)
    }
    
    @IBAction func tappedSearchButton(_ sender: Any) {
        guard let text = searchTextField.text else{return}
        presenter.didTappedSearchButton(searchText: text)
        
    }
    
    func showEmptyResultAlert(){
        let alert = UIAlertController(title: "検索結果がありません", message: "検索結果がありません、もう一度検索しなおしてください", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
}

extension SearchViewController:SearchViewOutput{
        
    func didLoadRepositories(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func toDetailOfSelectedCell(url:URL) {
        let showRepositoryVC = self.storyboard?.instantiateViewController(identifier: "showRepositoryVC", creator: nil) as! ShowRepositoryViewController
        showRepositoryVC.url = url
        self.present(showRepositoryVC, animated: true, completion: nil)
    }
}

extension SearchViewController:UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getRepositoryCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = presenter.getRepositoryForRowAt(indexPath: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryCell
        cell.setCell(repository: data)
        return cell
    }
}
extension SearchViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(indexPath: indexPath)
    }
    
}





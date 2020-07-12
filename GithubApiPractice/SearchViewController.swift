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
        initPresenter()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        webView = WKWebView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 20))
    }
    
    func initLayout(){
        
        
    }
    func initPresenter(){
         let model = SearchModel()
        self.presenter = SearchPresenter(view:self,model:model)
    }
    
    @IBAction func tappedSearchButton(_ sender: Any) {
        guard let text = searchTextField.text else{return}
        print(text)
        presenter.didTappedSearchButton(searchText: text)
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




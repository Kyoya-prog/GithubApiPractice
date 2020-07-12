//
//  ShowRepositoryViewController.swift
//  GithubApiPractice
//
//  Created by 松山響也 on 2020/07/12.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import UIKit
import WebKit

class ShowRepositoryViewController: UIViewController {

    var url:URL!
    var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView =  WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        webView.load(URLRequest(url: url))
        view.addSubview(webView)
    }

}

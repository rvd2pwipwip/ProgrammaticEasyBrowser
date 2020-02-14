//
//  ViewController.swift
//  ProgrammaticEasyBrowser
//
//  Created by Herve Desrosiers on 2020-02-13.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate { // promise to conform to WKNavigationDelegate protocol
    
    private var webView: WKWebView! // need to be stored as a property to be referenced later

    override func loadView() {
        super.loadView()
        webView = WKWebView() // create an instance of WKWebView web browser component and assign it to the webView property
        view.addSubview(webView) // put it in the view (no need for constraints; it will occupy the whole view)
        webView.navigationDelegate = self // when any web page navigation happens, please tell me – the current view controller.
        view = webView // make view (the root view of the view controller) that web view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Easy Web Browser"
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Right Item", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()
    
}

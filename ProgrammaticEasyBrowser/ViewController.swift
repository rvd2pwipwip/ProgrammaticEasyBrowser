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
    private var progressView: UIProgressView!

    override func loadView() {
        super.loadView()
        webView = WKWebView() // create an instance of WKWebView web browser component and assign it to the webView property
        view.addSubview(webView) // put it in the view (no need for constraints; it will occupy the whole view)
        webView.navigationDelegate = self // when any web page navigation happens, please tell me – the current view controller.
        view = webView // make view (the root view of the view controller) that web view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Easy Web Browser" // our view has a navigationController with a title property...
//        navigationItem.rightBarButtonItem = rightBarButtonItem // ...and a navigationItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped)) // action works here...
        
        progressView = UIProgressView(progressViewStyle: .default) // create progressView with defailt style
        progressView.sizeToFit() // set progressView layout size so that it fits its contents fully
        let progressButton = UIBarButtonItem(customView: progressView) // wrap progressView as custom view item to be used in toolbarItems' array
        
        // prepare KVO (key-value observing) to ask iOS to tell us when property X of object Y changes
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) //1. observer, 2. what 3. which value 4. context
        // Warning: in more complex applications, all calls to addObserver() should be matched with a call to removeObserver()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        toolbarItems = [progressButton, spacer, refresh] // items of the toolbar, displayed in array order
        navigationController?.isToolbarHidden = false // need to manually show the toolbar
        
        let url = URL(string: "https://www.stingray.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // Once you have registered as an observer using KVO, you must implement a method called observeValue()
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet) // no message for this action sheet
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel)) // no handler = dismiss alert controller on click
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem // for iPad action sheet pop up
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)! // using UIAlertAction handler method parameter here
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { // available through WKNavigationDelegate
        title = webView.title // navigationController title set to webView's title (most recent web page loaded)
    }
    
//    private let rightBarButtonItem: UIBarButtonItem = {
//        let barButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped)) // action not working here...
//        barButtonItem.tintColor = UIColor.blue
//        return barButtonItem
//    }()
    
}

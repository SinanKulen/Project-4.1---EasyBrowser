//
//  ViewController.swift
//  EasyBrowser (Project 4)
//
//  Created by Sinan Kulen on 7.07.2021.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var selectedWebsite : String!
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let wkforward = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.play , target: webView, action: #selector(webView.goForward))
        let wkback = UIBarButtonItem(barButtonSystemItem: .stop , target: webView, action: #selector(webView.goBack))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [wkforward, wkback, progressButton, spacer, refresh]
       
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        navigationController?.isToolbarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + selectedWebsite )!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            
                if host.contains(selectedWebsite) {
                    decisionHandler(.allow)
                    print("allowed:")
                    print(url!)
                    return
                
            }
            let alert = UIAlertController(title: "Don't move to other website", message: "Don't move", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true)
        }
        print("not allowed:")
        print(url!)
        decisionHandler(.cancel)
    }
}


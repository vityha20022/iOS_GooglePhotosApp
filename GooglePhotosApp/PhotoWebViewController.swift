//
//  WebViewController.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 20.02.2023.
//

import UIKit
import WebKit

class PhotoWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var photoSourceWebView: WKWebView!
    
    @IBOutlet weak var errorLabel: UILabel!
    var url: String!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoSourceWebView.navigationDelegate = self
        photoSourceWebView.uiDelegate = self

        guard let url = URL(string: url) else {
            errorLabel.isHidden = false
            return
        }
        
        photoSourceWebView.load(URLRequest(url: url))
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}

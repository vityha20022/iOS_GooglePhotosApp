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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var url: String!
    
    // MARK: - View lifecycle
    
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
    
    // MARK: - WKNavigationDelegate, WKUIDelegate
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}

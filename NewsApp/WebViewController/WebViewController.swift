//
//  WebViewController.swift
//  NewsApp
//
//  Created by Masaki on R 2/11/06.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WebViewController: UIViewController,WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    let webViewModel = WebViewModel()
    
    let urlstring = BehaviorRelay<String>(value: "")
    
    let url = PublishRelay<URL>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame:CGRect(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height))
        self.view.addSubview(webView)
    }
    
    func loadUrl(url: String){
            webView = WKWebView(frame:CGRect(x:0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height))
            let urlString = url
            let url = URL (string: url)
            webView.load(URLRequest(url: url!))
            self.view.addSubview(webView)
    }
}

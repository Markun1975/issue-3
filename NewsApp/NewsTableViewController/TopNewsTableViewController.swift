//
//  TopNewsTableViewController.swift
//  NewsApp
//
//  Created by Masaki on R 2/11/05.
//

import UIKit
import SegementSlide
import RxSwift
import RxCocoa

class TopNewsTableViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    var parser = XMLParser()
    
    var currentElementName: String!
    
    private let disposeBag = DisposeBag()
    
    var webUrlString = PublishRelay<String>()
    
    var newsItems = [NewsItemModel]()
    
    var newsMenue = NewsMenueViewController()
    
    let webVC = WebViewController()
    
    let newsViewModel = NewsTableViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        xmlParse()
        newsViewModel.subscribeUrl()
        urlManagement()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)
        let newsItem = self.newsItems[indexPath.row]
        let newsTitleLabel = cell.viewWithTag(1) as! UILabel
        newsTitleLabel.text = newsItems[indexPath.row].title
        
        let newsDateLabel = cell.viewWithTag(2) as! UILabel
        newsDateLabel.text = newsItems[indexPath.row].pubDate
        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .black
        return cell
    }
    
    
    
    func xmlParse(){
        //XLMパース
        let url = UrlConfig.TopNewsUrl
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
    }

    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item" {
            self.newsItems.append(NewsItemModel())
        }else{
            currentElementName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0 {
            let lastItem = self.newsItems[self.newsItems.count - 1]

            switch self.currentElementName {
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
//            case "thumhanail":
//                lastItem.image = UIImage
            default:break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
        print("parser完了")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //newsItemの何番目を渡すのか
        let newsItem = newsItems[indexPath.row]
        //Url入力して発火
        self.newsViewModel.urlString.accept(newsItem.url!)
    }
    
    func urlManagement(){
        self.newsViewModel.urlString.asObservable()
            .subscribe { (url) in
                self.webVC.loadUrl(url: url)
                self.show(self.webVC, sender: nil)
            } onError: { (error) in
                print(error)
            } onCompleted: {
                print("completed")
            }.disposed(by: disposeBag)
    }
}

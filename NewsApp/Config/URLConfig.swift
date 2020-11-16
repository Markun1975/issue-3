//
//  URLConfig.swift
//  NewsApp
//
//  Created by Masaki on R 2/11/10.
//

import Foundation

enum UrlConfig {
    
    //Yahoo トップニュースURL
    static let TopNewsUrl: URL = {
        return URL(string: "https://news.yahoo.co.jp/rss/topics/top-picks.xml")!
    }()
    
    
    
    
}

//
//  News.swift
//  The Morning View
//
//  Created by Xavier Jones on 7/2/21.
//

import Foundation

struct NewsStream: Codable{
    let status: String?
    let totalResults: Int?
    let articles: [Article]
    
    struct Article: Codable, Hashable{
        
        static func == (lhs: NewsStream.Article, rhs: NewsStream.Article) -> Bool {
            return lhs.url == rhs.url
        }
        
        let source: Source
        let author: String?
        let title: String?
        let description: String?
        let url: URL?
        let urlToImage: URL?
        let publishedAt: String
    }
    
    struct Source: Codable, Hashable{
        let id: String?
        let name: String?
    }
    
}

struct Section{
    var articles: [NewsStream.Article]
}

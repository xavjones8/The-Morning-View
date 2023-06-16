//
//  ArticleDisplaying.swift
//  The Morning View
//
//  Created by Xavier Jones on 7/13/21.
//

import Foundation
import UIKit

protocol NewsDisplaying{
    var articleThumbnail: UIImageView! {get set}
    var titleLabel: UILabel! {get set}
    var authorLabel: UILabel! {get set}
    var sourceLabel: UILabel! {get set}
    var dateLabel: UILabel! {get set}
    var descLabel: UILabel! {get set}
}

extension NewsDisplaying{
    func configure(for article: NewsStream.Article, newsController: NewsController){
        print(article)
        titleLabel.text = article.title ?? ""
        authorLabel.text = article.author ?? ""
        sourceLabel.text = article.source.name ?? ""
        dateLabel.text = article.publishedAt ?? ""
        descLabel.text = article.description ?? ""
        
        articleThumbnail.layer.cornerRadius = 10
        
        guard let imageUrl = article.urlToImage else {return}
        newsController.fetchImage(from: imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    articleThumbnail.image = image
                case .failure(_):
                    articleThumbnail.isHidden = true
                }
            }
        }
    }
}

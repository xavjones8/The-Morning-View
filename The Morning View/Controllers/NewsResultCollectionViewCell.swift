//
//  NewsResultCollectionViewCell.swift
//  The Morning View
//
//  Created by Xavier Jones on 7/15/21.
//

import UIKit

class NewsResultCollectionViewCell: UICollectionViewCell, NewsDisplaying {
    
    @IBOutlet weak var articleThumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
}

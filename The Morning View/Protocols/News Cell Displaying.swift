//
//  News Cell Displaying.swift
//  The Morning View
//
//  Created by Xavier Jones on 7/15/21.
//

import Foundation
import UIKit
protocol NewsDisplaying {
    var itemImageView: UIImageView! { get set }
    var titleLabel: UILabel! { get set }
    var detailLabel: UILabel! { get set }
}

extension NewsDisplaying {
    func configure(for item: News, storeItemController: NewsController) {
        titleLabel.text = item.name
        detailLabel.text = item.artist
        itemImageView?.image = UIImage(systemName: "photo")

        storeItemController.fetchImage(from: item.artworkURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.itemImageView.image = image
                case .failure(let error):
                    self.itemImageView.image = UIImage(systemName: "photo")
                    print("Error fetching image: \(error)")
                }
            }
        }
    }
}

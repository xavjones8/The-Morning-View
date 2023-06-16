//
//  NewsTableViewCell.swift
//  The Morning View
//
//  Created by Xavier Jones on 6/16/23.
//

import SwiftUI

struct NewsTableViewBannerCard: View {
    @Environment(\.openURL) var openURL
    let article: Article
    var body: some View {
        let screen_width = UIScreen.main.bounds.width
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .foregroundStyle(.white)
                .shadow(radius: 2, x: 0, y: 2)
            HStack(alignment: .top) {
                if let imageURL = article.urlToImage {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: (screen_width - 30) / 2, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 200)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(article.title)
                            .font(.title2)
                            .bold()
                            .minimumScaleFactor(0.65)
                            .lineLimit(3)
                            .layoutPriority(2)
                        Text(article.author ?? "Anonymous")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .minimumScaleFactor(0.3)
                            .layoutPriority(1)
                        Text(article.description ?? "Description")
                            .font(.caption2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(6)
                            .layoutPriority(0)
                    }
                    .padding(4)
                    .frame(height: 200)
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(article.title)
                            .font(.title2)
                            .bold()
                            .minimumScaleFactor(0.5)
                            .lineLimit(3)
                        Text(article.author ?? "Anonymous")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .minimumScaleFactor(0.5)
                        Text(article.description ?? "Description")
                            .minimumScaleFactor(0.5)
                            .lineLimit(6)
                            .font(.body)
                    }
                    .padding()
                    .frame(width: 350, height: 200)
                
                }
            }
        }
        .frame(width: screen_width - 30, height: 200)
        .onTapGesture {
            openURL(URL(string: article.url)!)
        }
        
    }
}

struct NewsTableViewBannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let articles = NewsAPI().fetchMockNews().articles
        NewsTableViewBannerCard(article: articles[0])
    }
}

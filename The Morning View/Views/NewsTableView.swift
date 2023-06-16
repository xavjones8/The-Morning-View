//
//  NewsTableView.swift
//  The Morning View
//
//  Created by Xavier Jones on 6/16/23.
//

import SwiftUI

struct NewsTableView: View {
    private let newsAPI = NewsAPI()
    @State private var articles: [Article] = []
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Top Headlines")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                LazyHStack {
                    TabView {
                        ForEach(articles) { article in
                            NewsTableViewBannerCard(article: article)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(width: UIScreen.main.bounds.width, height: 220)
                }
                .frame(width: UIScreen.main.bounds.width, height: 220)
                Spacer()
            }
        }.onAppear {
            if let result = newsAPI.fetchNews()?.articles {
                articles.append(contentsOf: result)
            }
            
            print(articles)
        }
        .preferredColorScheme(.light)
    }
}

struct NewsTableView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTableView()
    }
}

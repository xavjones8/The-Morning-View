//
//  NewsAPI.swift
//  The Morning View
//
//  Created by Xavier Jones on 6/16/23.
//

import Foundation

final class NewsAPI {
    func fetchNews() -> NewsResult? {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(MyNewsAPIKey)")
        let session = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)
        var newsResult: NewsResult?
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    newsResult = try JSONDecoder().decode(NewsResult.self, from: data)
                    semaphore.signal()
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
        semaphore.wait()
        return newsResult
    }
    func fetchMockNews() -> NewsResult {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "MockResponse", withExtension: "json")!
        var json: Data
        json = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(NewsResult.self, from: json)
    }
}

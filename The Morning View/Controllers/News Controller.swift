//
//  News Controller.swift
//  The Morning View
//
//  Created by Xavier Jones on 7/13/21.
//

import Foundation
import UIKit

class NewsController{
    func fetchNews(search searchType: SearchType, matching query: [URLQueryItem] ,completion: @escaping (Result<NewsStream, Error>) -> Void){
        //Defines baseline API call with the api key
        var urlComponents = URLComponents(string: "https://newsapi.org/v2/\(searchType.rawValue)")!
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: "c54957f777bb4edc8e9bd6ef97f94b27")] + query
        print(urlComponents)
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(NewsStream.self, from: data)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    enum NewsThumbnailError: Error, LocalizedError {
        case imageDataMissing
    }

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NewsThumbnailError.imageDataMissing))
            }
        }
        
        task.resume()
    }

}


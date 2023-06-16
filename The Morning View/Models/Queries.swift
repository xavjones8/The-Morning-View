//
//  Queries.swift
//  The Morning View
//
//  Created by Xavier Jones on 7/14/21.
//

import Foundation

extension Date{
    func formatDate()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}

struct SearchEverything{
    var query: String!
    var from: Date?
    var to: Date?
    var sort: SortBy?
    
    enum SortBy: String{
        case publishedAt
        case relevancy
        case popularity
    }
    func createEverythingSearch() -> [URLQueryItem]{
        var params: [URLQueryItem] = []
        
        
        guard let q = self.query else{return SearchTopHeadlines().createTopHeadlinesSearch()}
        params += [URLQueryItem(name: "q", value: q)]
        
        if  let startingDate = self.from{
            params += [URLQueryItem(name: "from", value: startingDate.formatDate())]
        }
        if  let endingDate = self.to{
            params += [URLQueryItem(name: "to", value: endingDate.formatDate())]
        }
        
        if let sortBy = self.sort{
            params += [URLQueryItem(name: "sortBy", value: sortBy.rawValue)]
        }
        return params
    }
}

struct SearchTopHeadlines{
    var country: String{
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String{
            return countryCode
        }else{
            return "us"
        }
    }
    var category: Category?
    
    enum Category: String{
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
    }
    func createTopHeadlinesSearch() -> [URLQueryItem]{
        var params: [URLQueryItem] = [URLQueryItem(name: "country", value: self.country)]
        if let category = self.category{
            params += [URLQueryItem(name: "category", value: category.rawValue)]
        }
        return params
    }
}




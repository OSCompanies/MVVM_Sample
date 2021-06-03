//
//  WebService.swift
//  HDTest
//
//  Created by Gun Lee on 2021/06/03.
//  Copyright © 2021 gun. All rights reserved.
//

import Foundation

class WebService {
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                print(articleList ?? "no data")
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles ?? "no data")
            }
        }.resume()
    }
}

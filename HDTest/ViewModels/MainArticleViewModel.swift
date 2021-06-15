//
//  MainArticleViewModel.swift
//  HDTest
//
//  Created by Gun Lee on 2021/06/04.
//  Copyright © 2021 gun. All rights reserved.
//

import UIKit

class MainArticleViewModel: NSObject {
    var article: Article?
    var articles: [Article]?
    var numberOfSections = 1
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func articleAtIndex(_ index: Int) -> Article {
        let article = self.articles![index]
        return article
    }
    
    func fetchData(completion: @escaping () -> Void) {
        
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2021-05-15&sortBy=publishedAt&apiKey=e9b514c39c5f456db8ed4ecb693b0040")
        WebService().getArticles(url: url!) {
            (articles) in
            
            if let data = articles {
                self.articles = data
                completion()
            }
        }
    }
}

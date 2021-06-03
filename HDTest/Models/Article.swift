//
//  Article.swift
//  HDTest
//
//  Created by Gun Lee on 2021/06/03.
//  Copyright © 2021 gun. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
}

//
//  PostData.swift
//  Hacker News Client (SWIFTUI)
//
//  Created by Tyler Dakin on 3/17/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let articles: [Article]
}

struct Article: Decodable, Identifiable {
    var id: String {
        return url
    }
    
    let title: String
    let author: String?
    let url: String
    let urlToImage: String?
//    let source: [String:String]?
    let description: String?
    let publishedAt: String?
    let content: String?
    
    
}

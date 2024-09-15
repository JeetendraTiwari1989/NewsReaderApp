//
//  NewsResponse.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [NewsArticle]
}

struct NewsArticle: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
        case urlToImage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.urlToImage = try? container.decode(String.self, forKey: .urlToImage)
    }

    init(id: UUID = UUID(), title: String, description: String? = nil, url: String, urlToImage: String? = nil, isBookmarked: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
    }
}



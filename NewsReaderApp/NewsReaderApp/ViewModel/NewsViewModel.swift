//
//  NewsViewModel.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var bookmarkedArticles: [BookmarkedArticle] = []
    @Published var category: String = "general"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchNews()
        fetchBookmarkedArticles()
    }
    
    func fetchNews(category: String = "general") {
       let urlString = "\(Configuration.baseUrl)?category=\(category)&apiKey=\(Configuration.apiKey)"
        NewsAPIService.shared.fetchData(from: urlString) { [weak self] (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles
                }
            case .failure(let error):
                print("Failed to fetch news: \(error)")
            }
        }
    }
    
    func fetchBookmarkedArticles() {
        bookmarkedArticles = CoreDataManager.shared.fetchBookmarkedArticles()
    }
    
    func bookmarkArticle(_ article: NewsArticle) {
        CoreDataManager.shared.saveArticle(article)
        fetchBookmarkedArticles()
    }
    
    func removeBookmark(_ article: BookmarkedArticle) {
        CoreDataManager.shared.deleteArticle(article)
        fetchBookmarkedArticles()
    }
}

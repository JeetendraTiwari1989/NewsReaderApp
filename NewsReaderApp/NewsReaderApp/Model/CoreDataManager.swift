//
//  CoreDataManager.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager() // Singleton
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "NewsReader")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error)")
            }
        }
    }    
    
    func saveArticle(_ newsArticle: NewsArticle) {
        let context = persistentContainer.viewContext
        let article = BookmarkedArticle(context: context)
        article.id = newsArticle.id
        article.title = newsArticle.title
        article.summary = newsArticle.description
        article.url = newsArticle.url
        article.urlToImage = newsArticle.urlToImage
        
        do {
            try context.save()
        } catch {
            print("Failed to save article: \(error)")
        }
    }
    
    func fetchBookmarkedArticles() -> [BookmarkedArticle] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<BookmarkedArticle> = BookmarkedArticle.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch articles: \(error)")
            return []
        }
    }
    
    func deleteArticle(_ article: BookmarkedArticle) {
        let context = persistentContainer.viewContext
        context.delete(article)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete article: \(error)")
        }
    }
}

//
//  CoreDataManagerTests.swift
//  NewsReaderAppTests
//
//  Created by Jeetendra on 14/09/24.
//

import XCTest
import CoreData
@testable import NewsReaderApp


final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager.shared
    }

    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
    }

    func testSaveArticle() {
        let article = NewsArticle(id: UUID(), title: "Test Title", description: "Test Description", url: "http://test.com", urlToImage: nil)

        coreDataManager.saveArticle(article)
        let bookmarkedArticles = coreDataManager.fetchBookmarkedArticles()

        XCTAssertTrue(bookmarkedArticles.contains { $0.title == article.title }, "Article should be saved in Core Data.")
    }

    func testFetchBookmarkedArticles() {
        let bookmarkedArticles = coreDataManager.fetchBookmarkedArticles()
        XCTAssertNotNil(bookmarkedArticles, "Should return a list of bookmarked articles")
    }

    func testDeleteArticle() {
        let article = NewsArticle(id: UUID(), title: "Test Title", description: "Test Description", url: "http://test.com", urlToImage: nil)

        coreDataManager.saveArticle(article)
        let bookmarkedArticle = coreDataManager.fetchBookmarkedArticles().first!

        coreDataManager.deleteArticle(bookmarkedArticle)
        let bookmarkedArticlesAfterDelete = coreDataManager.fetchBookmarkedArticles()

        XCTAssertFalse(bookmarkedArticlesAfterDelete.contains(bookmarkedArticle), "Article should be deleted from Core Data.")
    }
}

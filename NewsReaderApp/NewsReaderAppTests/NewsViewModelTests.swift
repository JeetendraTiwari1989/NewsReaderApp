//
//  NewsReaderAppTests.swift
//  NewsReaderAppTests
//
//  Created by Jeetendra on 14/09/24.
//

import XCTest
import Combine
@testable import NewsReaderApp

final class NewsViewModelTests: XCTestCase {
    var viewModel: NewsViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = NewsViewModel()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchNews() {
        let expectation = XCTestExpectation(description: "Fetch news and update articles")

        viewModel.$articles
            .dropFirst() // Skip the initial value
            .sink { articles in
                XCTAssertGreaterThan(articles.count, 0, "Articles should be fetched and updated")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchNews(category: "technology")

        wait(for: [expectation], timeout: 5.0)
    }

    func testBookmarkArticle() {
        let article = NewsArticle(id: UUID(), title: "Test Article", description: "Test Description", url: "http://test.com", urlToImage: nil)
        viewModel.bookmarkArticle(article)

        XCTAssertTrue(viewModel.bookmarkedArticles.contains { $0.title == article.title }, "Article should be bookmarked.")
    }

    func testRemoveBookmark() {
        let article = NewsArticle(id: UUID(), title: "Test Article", description: "Test Description", url: "http://test.com", urlToImage: nil)
        viewModel.bookmarkArticle(article)

        let bookmarkedArticle = viewModel.bookmarkedArticles.first!
        viewModel.removeBookmark(bookmarkedArticle)

        XCTAssertFalse(viewModel.bookmarkedArticles.contains(bookmarkedArticle), "Article should be removed from bookmarks.")
    }
}


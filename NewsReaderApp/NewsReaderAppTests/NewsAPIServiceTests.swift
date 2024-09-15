//
//  NewsAPIServiceTests.swift
//  NewsReaderAppTests
//
//  Created by Jeetendra on 14/09/24.
//

import XCTest
@testable import NewsReaderApp // Replace with your app's module name

final class NewsAPIServiceTests: XCTestCase {
    func testFetchNewsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch news successfully")
        let category = "technology"

        NewsAPIService.shared.fetchNews(for: category) { result in
            switch result {
            case .success(let articles):
                XCTAssertGreaterThan(articles.count, 0, "Should have received articles.")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure.")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchGeneralNewsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch news successfully")
        let category = "general"

        NewsAPIService.shared.fetchNews(for: category) { result in
            switch result {
            case .success(let articles):
                XCTAssertGreaterThan(articles.count, 0, "Should have received articles.")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure.")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchNewsFailure() {
        let expectation = XCTestExpectation(description: "Fail to fetch news")
        let invalidCategory = "invalid_category_test"

        NewsAPIService.shared.fetchNews(for: invalidCategory) { result in
            switch result {
            case .success(let articles):
                XCTAssertEqual(articles.count, 0, "Invalid category we have received empaty articles.")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "Expected an error but got nil.")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}


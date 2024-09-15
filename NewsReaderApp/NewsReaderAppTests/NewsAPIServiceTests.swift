//
//  NewsAPIServiceTests.swift
//  NewsReaderAppTests
//
//  Created by Jeetendra on 14/09/24.
//


import XCTest
@testable import NewsReaderApp

class NewsAPIServiceTests: XCTestCase {
    
    var apiService: NewsAPIService!
    
    override func setUp() {
        super.setUp()
        apiService = NewsAPIService.shared
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        // Define the URL of the API endpoint you want to test.
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(Configuration.apiKey)"
        
        // Define the expectation
        let expectation = self.expectation(description: "Completion handler invoked")
        
        // Define the result variable
        var result: Result<NewsResponse, Error>?
        
        // Call the fetchData method
        apiService.fetchData(from: urlString) { (response: Result<NewsResponse, Error>) in
            result = response
            expectation.fulfill()
        }
        
        // Wait for the expectations to be fulfilled
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // Assert that the result is a success and validate the data
        switch result {
        case .success(let newsResponse):
            XCTAssertNotNil(newsResponse.articles, "Articles should not be nil")
            XCTAssertGreaterThan(newsResponse.articles.count, 0, "There should be at least one article")
        case .failure(let error):
            XCTFail("Expected success, but got failure: \(error)")
        case .none:
            XCTFail("Expected result, but got nil")
        }
    }
    
    func testFetchDataFailure() {
        // Define an invalid URL to simulate failure
        let urlString = "https://invalid.url/endpoint"
        
        // Define the expectation
        let expectation = self.expectation(description: "Completion handler invoked")
        
        // Define the result variable
        var result: Result<NewsResponse, Error>?
        
        // Call the fetchData method
        apiService.fetchData(from: urlString) { (response: Result<NewsResponse, Error>) in
            result = response
            expectation.fulfill()
        }
        
        // Wait for the expectations to be fulfilled
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // Assert that the result is a failure
        switch result {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure(let error):
            XCTAssertNotNil(error, "Error should not be nil")
        case .none:
            XCTFail("Expected result, but got nil")
        }
    }
}

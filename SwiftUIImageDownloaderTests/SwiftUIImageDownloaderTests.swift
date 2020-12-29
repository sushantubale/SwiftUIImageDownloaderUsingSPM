//
//  SwiftUIImageDownloaderTests.swift
//  SwiftUIImageDownloaderTests
//
//  Created by Sushant Ubale on 12/27/20.
//

import XCTest
@testable import SwiftUIImageDownloader
@testable import SwiftUIImagePackage

class SwiftUIImageDownloaderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataDecoder() {
        let currentPage = 5
        let dataDecoder = DataDecoder(url: URL(string: "\(Constants.URL.base)\(Constants.URL.apiKeyPath)\(Constants.apiKey)\(Constants.URL.page)\(currentPage)\(Constants.URL.sort)") ?? URL(string: "")!)
        
        XCTAssertEqual(dataDecoder.url, URL(string: "\(Constants.URL.base)\(Constants.URL.apiKeyPath)\(Constants.apiKey)\(Constants.URL.page)\(currentPage)\(Constants.URL.sort)"))
        
    }
    
    func testHandleEmptyTotalItems() {
        let contentViewModel = ContentViewViewModel()
        let result = Result(results: [Movie(adult: true, backdrop_path: "test_path_one", genre_ids: [1], id: 1, original_language: "test_language_one", original_title: "test_title_one", overview: "test_overview_one", popularity: 1.0, poster_path: "test_poster_one", release_date: "test_releasedate_one", title: "test_title_one", video: true, vote_average: 1.0, vote_count: 1)], total_pages: 1, total_results: 1)
        contentViewModel.handleEmptyTotalItems(result)
        contentViewModel.posterImages = result.results
        contentViewModel.dataFetched = true
        
        XCTAssertEqual(contentViewModel.posterImages, result.results)
        XCTAssertEqual(contentViewModel.dataFetched, true)
    }
    
    func testHandleAppendTotalItemsCase() {
        let contentViewModel = ContentViewViewModel()
        let resultTwo = Result(results: [Movie(adult: true, backdrop_path: "test_path_two", genre_ids: [1], id: 1, original_language: "test_language_two", original_title: "test_title_two", overview: "test_overview_two", popularity: 1.0, poster_path: "test_poster_two", release_date: "test_releasedate_two", title: "test_title_two", video: true, vote_average: 1.0, vote_count: 1)], total_pages: 1, total_results: 1)
        let resultThree = Result(results: [Movie(adult: true, backdrop_path: "test_path_two", genre_ids: [1], id: 1, original_language: "test_language_two", original_title: "test_title_two", overview: "test_overview_two", popularity: 1.0, poster_path: "test_poster_two", release_date: "test_releasedate_two", title: "test_title_two", video: true, vote_average: 1.0, vote_count: 1)], total_pages: 1, total_results: 1)

        contentViewModel.handleAppendTotalItemsCase(resultTwo)
        contentViewModel.handleAppendTotalItemsCase(resultThree)
        
        XCTAssertTrue(contentViewModel.posterImages.contains(resultTwo.results[0]))
        XCTAssertTrue(contentViewModel.posterImages.contains(resultThree.results[0]))
        XCTAssertEqual(contentViewModel.dataFetched, true)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

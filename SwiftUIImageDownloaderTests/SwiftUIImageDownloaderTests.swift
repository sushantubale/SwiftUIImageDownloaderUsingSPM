//
//  SwiftUIImageDownloaderTests.swift
//  SwiftUIImageDownloaderTests
//
//  Created by Sushant Ubale on 12/27/20.
//

import XCTest
import SwiftUI

@testable import SwiftUIImageDownloader
@testable import SwiftUIImagePackage

class SwiftUIImageDownloaderTests: XCTestCase {

    let movie = Result(results: [Movie(adult: true, backdrop_path: "test_path_one", genre_ids: [1], id: 1, original_language: "test_language_one", original_title: "test_title_one", overview: "test_overview_one", popularity: 1.0, poster_path: "test_poster_one", release_date: "test_releasedate_one", title: "test_title_one", video: true, vote_average: 1.0, vote_count: 1)], total_pages: 1, total_results: 1)

    func testDataDecoder() {
        let currentPage = 5
        let dataDecoder = DataDecoder(url: URL(string: "\(Constants.URL.base)\(Constants.URL.apiKeyPath)\(Constants.apiKey)\(Constants.URL.page)\(currentPage)\(Constants.URL.sort)") ?? URL(string: "")!)
        
        XCTAssertEqual(dataDecoder.url, URL(string: "\(Constants.URL.base)\(Constants.URL.apiKeyPath)\(Constants.apiKey)\(Constants.URL.page)\(currentPage)\(Constants.URL.sort)"))
        
    }
    
    func testHandleEmptyTotalItems() {
        let contentViewModel = ContentViewViewModel()
        contentViewModel.handleEmptyTotalItems(movie)
        contentViewModel.posterImages = movie.results
        contentViewModel.dataFetched = true
        XCTAssertEqual(contentViewModel.posterImages, movie.results)
        XCTAssertEqual(contentViewModel.dataFetched, true)
    }
    
    func testHandleAppendTotalItemsCase() {
        let contentViewModel = ContentViewViewModel()
        contentViewModel.handleAppendTotalItemsCase(movie)
        XCTAssertEqual(contentViewModel.posterImages[0].adult, movie.results[0].adult)
        XCTAssertEqual(contentViewModel.posterImages[0].video, movie.results[0].video)
        XCTAssertEqual(contentViewModel.posterImages[0].backdrop_path, movie.results[0].backdrop_path)
        XCTAssertEqual(contentViewModel.dataFetched, true)
    }
    
    func testMovieView() {
        let movieView = MoviewView(image: UIImage(systemName: "pencil")!, title: "testMovie")
        XCTAssertEqual(movieView.title, "testMovie")
        XCTAssertEqual(movieView.image, UIImage(systemName: "pencil")!)
    }
}

//
//  MovieModel.swift
//  SwiftUIImageDownloader
//
//  Created by Sushant Ubale on 12/28/20.
//

import Foundation

struct Result: Decodable {
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}
struct Movie: Decodable, Hashable {
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}

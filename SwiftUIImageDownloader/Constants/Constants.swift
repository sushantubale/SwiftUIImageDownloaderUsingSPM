//
//  Constants.swift
//  SwiftUIImageDownloader
//
//  Created by Sushant Ubale on 12/28/20.
//

import Foundation

struct Constants {

    static let apiKey = "37db4ce45e9a67de1a89922138eda011"
    
    struct URL {
        static let base = "http://api.themoviedb.org/3"
        static let basePoster = "http://image.tmdb.org/t/p"
        static let apiKeyPath = "/discover/movie?api_key="
        static let page = "&page="
        static let sort = "&sort_by=popularity.desc"
    }
    
    static let fullURL = "\(Constants.URL.base)/discover/movie?api_key=\(Constants.apiKey)&page=\(1)&sort_by=popularity.desc"
    
    static let posterPath = "w185"
    static let downloadingImage = "Downloading Image...."
    static let exclamationMarkImageName = "exclamationmark.triangle"
    static let noDataAvailable = "No More Data Available"
    static let moviePosterTitle = "Popular Movies"
    static let downloadingData = "Downloading...."
    
    static let loadingTitle = "Loading Title"
    static let loading = "Loading..."
    static let overView = "Overview - "
    static let unknownOverView = "Unknown overview"
    static let language = "Language - "
    static let unknownLanguage = "Unknown language"
    static let releaseDate = "Release date - "
    static let unknownReleaseDate = "Unknown date"
    static let popularity = "Popularity - "
    static let unknownPopularity = 0
    
    static let dataReceived = "Data received"
}

//
//  MoviewDetailView.swift
//  SwiftUIImageDownloader
//
//  Created by Sushant Ubale on 12/28/20.
//

import SwiftUI
import SwiftUIImagePackage

//MARK: - MovieDetailView
struct MoviewDetailView: View {
    
    var movie: Movie?
    init(movie: Movie) {
        self.movie = movie
    }
    var body: some View {
        
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(movie?.original_title ?? "\(Constants.loadingTitle)")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ImageFetcherView(url: URL(string: "\(Constants.URL.basePoster)/\(Constants.posterPath)/\(movie?.poster_path ?? "")") ?? URL(string: "")!, placeholder: {
                        ProgressView("\(Constants.loading)")
                            .scaleEffect(1.5, anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .foregroundColor(.blue)
                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2, alignment: .center)
                        
                    }, movieView: { (movieView) -> MoviewView in
                        MoviewView(image: movieView.image!, title: movieView.title!)
                    }, title: "")
                    
                    HStack(alignment: .top) {
                        Text("\(Constants.overView)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(movie?.overview ?? "\(Constants.unknownOverView)")")
                            .font(.title2)
                    }
                    
                    HStack(alignment: .top) {
                        Text("\(Constants.language)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(movie?.original_language ?? "\(Constants.unknownLanguage)")")
                            .font(.title2)
                    }
                    
                    HStack(alignment: .top) {
                        Text("\(Constants.releaseDate)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(movie?.release_date ?? "\(Constants.unknownReleaseDate)")")
                            .font(.title2)
                    }
                    
                    HStack(alignment: .top) {
                        Text("\(Constants.popularity)")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(movie?.popularity ?? 1.0)")
                            .font(.title2)
                    }
                    Spacer()
                }.padding()
            }
            .navigationBarItems(trailing:
                    HStack(spacing: 30) {
                        ShareButton()
                    }
            )
    }
}

struct MoviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewDetailView(movie: Movie(adult: false, backdrop_path: "backdrop_path", genre_ids: [1], id: 1, original_language: "original_language", original_title: "original_title", overview: "overview", popularity: 1.0, poster_path: "poster_path", release_date: "release_date", title: "title", video: false, vote_average: 1.0, vote_count: 1))
    }
}



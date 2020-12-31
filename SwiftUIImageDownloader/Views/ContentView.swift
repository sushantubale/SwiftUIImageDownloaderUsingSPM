//
//  ContentView.swift
//  SwiftUIImageDownloader
//
//  Created by Sushant Ubale on 12/27/20.
//

import SwiftUI
import SwiftUIImagePackage

//MARK: - ContentView
/// This View is the main view of the app. Data dependency is on ContentViewModel.

struct ContentView: View {

    @ObservedObject var request = ContentViewViewModel()
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        
        if request.dataFetched == true {
            NavigationView {
                if let posterImage = request.posterImages {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 100) {
                            ForEach(posterImage, id: \Movie.id) { url in
                                NavigationLink(destination: MoviewDetailView(movie: url)) {
                                    ImageFetcherView(url: (URL(string: "\(Constants.URL.basePoster)/\(Constants.posterPath)/\(url.poster_path)") ?? URL(string: ""))!, placeholder: {
                                        ProgressView("\(Constants.downloadingImage)")
                                            .scaleEffect(1.5, anchor: .center)
                                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                            .foregroundColor(.blue)
                                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2, alignment: .center)
                                    }, movieView: { (moviewView) -> MoviewView in
                                        MoviewView(image: moviewView.image!, title: moviewView.title!)
                                        
                                    }, title: url.original_title)
                                }
                                
                                .frame(idealHeight: UIScreen.main.bounds.width / 2)
                                
                                .onAppear {
                                    if request.totalItems >= request.posterImages.count {
                                        request.request()
                                    }
                                }
                                .frame(idealHeight: UIScreen.main.bounds.width / 2)
                            }

                        }
                        if request.showDataNotAvailable == true {
                            Divider()
                            HStack(alignment: .center, spacing: 10) {
                                Image(systemName: "\(Constants.exclamationMarkImageName)")
                                    .foregroundColor(Color.red)
                                    .scaleEffect(1.1)
                                Text("\(Constants.noDataAvailable)")
                            }
                        }
                    }
                    .navigationBarTitle(Text("\(Constants.moviePosterTitle)"))
                    .navigationBarItems(
                        leading:
                            HStack(spacing: 30) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.yellow)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Rectangle())

                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.blue)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Rectangle())
                            },
                        trailing:
                            HStack(spacing: 30) {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.blue)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Rectangle())
                                Image(systemName: "arrow.up.heart.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.blue)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Rectangle())
                            }
                    )
                }
            }
            
        } else if request.dataFetched == false {
            ProgressView("\(Constants.downloadingData)")
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    request.request()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


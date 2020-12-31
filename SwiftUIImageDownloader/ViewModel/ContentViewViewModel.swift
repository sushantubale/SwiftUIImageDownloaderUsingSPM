//
//  Request.swift
//  SwiftUIImageDownloader
//
//  Created by Sushant Ubale on 12/28/20.
//

import Foundation
import SwiftUI
import Combine
import SwiftUIImagePackage

class ContentViewViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published var dataFetched = false
    @Published var posterImages = [Movie]()
    @Published var totalItems: Int = 0
    private var currentPage = 1
    @Published var showDataNotAvailable: Bool = false
    
    deinit {
        self.cancellable?.cancel()
    }
    
    func request() {
        let dataDecoder = DataDecoder(url: URL(string: "\(Constants.URL.base)\(Constants.URL.apiKeyPath)\(Constants.apiKey)\(Constants.URL.page)\(currentPage)\(Constants.URL.sort)") ?? URL(string: "")!)

        self.cancellable = dataDecoder.dataTaskPublisher()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] response in
                guard let strongSelf = self else { return }
                strongSelf.dataFetched = false
            })
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("\(Constants.dataReceived)")
                case .failure:
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.showDataNotAvailable = true
                    }
                }
            } receiveValue: { [weak self] (movies: Result) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.totalItems += movies.results.count
                    if strongSelf.posterImages.isEmpty {
                        strongSelf.handleEmptyTotalItems(movies)
                    } else {
                        strongSelf.handleAppendTotalItemsCase(movies)
                    }
                }
            }
    }
    
    func handleEmptyTotalItems(_ movie: Result) {
        self.posterImages = movie.results
        self.dataFetched = true
        self.currentPage += 1
    }
    
    func handleAppendTotalItemsCase(_ movie: Result) {
        self.posterImages.append(contentsOf: movie.results)
        self.dataFetched = true
        self.currentPage += 1
    }
}

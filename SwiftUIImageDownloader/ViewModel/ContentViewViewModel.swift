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
    
    func request() {
        let dataDecoder = DataDecoder(url: URL(string: "\(Constants.URL.base)\(Constants.URL.apiKeyPath)\(Constants.apiKey)\(Constants.URL.page)\(currentPage)\(Constants.URL.sort)") ?? URL(string: "")!)

        self.cancellable = dataDecoder.dataTaskPublisher()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { response in
              self.dataFetched = false
            })
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("\(Constants.dataReceived)")
                case .failure(let error):
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.showDataNotAvailable = true
                    }
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (movies: Result) in
                guard let strongSelf = self else { return }

                DispatchQueue.main.async {
                    strongSelf.totalItems += movies.results.count
                    if strongSelf.posterImages.isEmpty {
                        strongSelf.posterImages = movies.results
                        strongSelf.dataFetched = true
                        strongSelf.currentPage += 1
                    } else {
                        strongSelf.posterImages.append(contentsOf: movies.results)
                        strongSelf.dataFetched = true
                        strongSelf.currentPage += 1
                    }
                }
            }
    }
}

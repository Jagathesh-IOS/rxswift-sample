//
//  HomeViewModel.swift
//  CinemaBox
//
//  Created by Jack on 02/08/21.
//

import Foundation
import RxSwift

enum homeSection: String {
    case topRated = "Top Rated"
    case popular = "Popular"
}

class HomeViewModel {
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<APIServiceError> = PublishSubject()
    let popularMovies: PublishSubject<[Movie]> = PublishSubject()
    
    func fetchPopularMovies() {
        self.loading.onNext(true)
        APIRequest.shared.fetchMovies(from: .popular) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let response):
                self.popularMovies.onNext(response.results ?? [Movie]())
            case .failure(let error):
                self.error.onNext(error)
            }
        }
    }
}

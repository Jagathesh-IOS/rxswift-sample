//
//  HomeViewController.swift
//  CinemaBox
//
//  Created by Jack on 02/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private let homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.observingError()
        self.bindTableView()
        self.homeViewModel.fetchPopularMovies()
    }
    
    // MARK: - Private Methods
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.registerNib(PopularMovieTableViewCell.self)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        // tableView.rx.setDataSource(self).disposed(by: disposeBag)
    }
    
    private func observingError() {
        // observing errors
        homeViewModel.error.observe(on: MainScheduler.instance).subscribe(onNext: { error in
            switch error {
            case .apiError: print("API error")
            case .decodeError: print("Parser error")
            default: print("Unknown error")
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Binding
extension HomeViewController {
    private func bindTableView() {
        // Observing loader to show/hide loading indicator
        homeViewModel.loading.bind(to: self.loadingIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        // Binding popular movies to tableView
        homeViewModel.popularMovies
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "PopularMovieTableViewCell", cellType: PopularMovieTableViewCell.self)) { (row, item, cell) in
                cell.loadData(result: item)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Movie.self).subscribe { movie in
            print("Selected movie: \(movie)")
        }.disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

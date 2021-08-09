//
//  PopularMovieTableViewCell.swift
//  CinemaBox
//
//  Created by Jack on 03/08/21.
//

import UIKit
import Kingfisher

class PopularMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureCell()
    }
    
    func configureCell() {
        movieImageView.layer.cornerRadius = 8.0
        movieImageView.clipsToBounds = true
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func loadData(result: Movie) {
        let url = APIRequest.shared.getImageURL(for: result.backdropPath ?? "")
        self.movieImageView.kf.setImage(with: url)
        self.titleLabel.text = result.title ?? ""
        self.descriptionLabel.text = result.overview ?? ""
    }
}

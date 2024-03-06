//
//  MovieTableViewCell.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/4.
//

import UIKit
import Combine

class MovieTableViewCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil)}

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var downloadPublisher = PassthroughSubject<Void, Never>()
    
    var viewModel: MovieCellViewModel? {
        didSet {
            self.bindingToView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        mainView.layer.cornerRadius = 16
        headImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        headImageView.layer.cornerRadius = 16
    }
    
    func bindingToView() {
        
        if let title = viewModel?.movie.title {
            self.titleLabel.text = title
        }else {
            self.titleLabel.text = viewModel?.movie.name
        }
        
        if let date = viewModel?.movie.releaseDate {
            self.subtitleLabel.text = "\(date.dateFormate("MMM d, y"))"
        }else {
            self.subtitleLabel.text = "\(viewModel?.movie.firstAirDate ?? "")"
        }
        
        if let image = viewModel?.movie.thumbnailImage {
            self.headImageView.image = image
        }else {
            self.headImageView.image = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.downloadPublisher.send()
            })
        }
        
        movieType.text = "\(viewModel?.movie.mediaType ?? "MOVIE")/\(viewModel?.movie.originalLanguage ?? "EN")".uppercased()
        
        if let rate = viewModel?.movie.voteAverage {
            rateLabel.text = String(format: "%.1f", rate)
        }else {
            rateLabel.text = "0"
        }
        
        voteLabel.text = "VOTE:\((viewModel?.movie.voteCount ?? 0))"
        
        overviewLabel.text = viewModel?.movie.overview
        
    }
    
}

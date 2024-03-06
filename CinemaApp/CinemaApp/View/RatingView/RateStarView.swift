//
//  RateStarView.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/6.
//

import UIKit

class RateStarView: UIView {
    
    private let rateCount = 5
    private var rateIcons = [UIImageView]()

    var rate: Int = 0 {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    private func initUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        self.addSubview(stackView)
        
        for _ in 0..<rateCount {
            let item = UIImageView(image: UIImage(named: "icon_unfilled_star"))
            item.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(item)
            rateIcons.append(item)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    private func updateView() {
        for(index, item) in rateIcons.enumerated() {
            item.image = rate > index ? UIImage(named: "icon_filled_star") : UIImage(named: "icon_unfilled_star")
        }
    }
}

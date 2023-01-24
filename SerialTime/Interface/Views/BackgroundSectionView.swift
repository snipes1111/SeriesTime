//
//  BackgroundSectionView.swift
//  SerialTime
//
//  Created by user on 05/01/2023.
//

import UIKit

final class BackgroundSectionView: CustomUICollectionReusableView {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView.seriesImageView()
        imageView.image = UIImage(named: Constants.imageBackground)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.imageView = imageView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

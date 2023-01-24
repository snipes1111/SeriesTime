//
//  EpisodeBanner.swift
//  SerialTime
//
//  Created by user on 04/01/2023.
//

import UIKit

class EpisodeBanner: UICollectionReusableView {
    var textLabel: CustomLabel!
    var episode: Series? {
        didSet {
            guard let text = episode?.seriesDescription else { return }
            textLabel.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = CustomLabel(type: .banner)
        label.text = episode?.seriesDescription ?? ""
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        textLabel = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

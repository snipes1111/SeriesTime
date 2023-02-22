//
//  HeaderCollectionViewCell.swift
//  SerialTime
//
//  Created by user on 03/01/2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    var textLabel: CustomLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = CustomLabel(type: .header)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        textLabel = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

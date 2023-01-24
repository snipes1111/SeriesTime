//
//  Custom Cells.swift
//  SerialTime
//
//  Created by user on 20/01/2023.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .init(width: 0, height: 3)
        layer.shadowRadius = 4
        contentView.backgroundColor = UIColor.detailVcBackgroundColor
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

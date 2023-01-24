//
//  Buttons and Labels.swift
//  SerialTime
//
//  Created by user on 20/01/2023.
//

import Foundation
import UIKit

extension UIImage {
    
    static func customBackImage() -> UIImage {
        return UIImage(systemName: "arrowshape.turn.up.backward")!
    }
}

extension UIButton {
    static func editButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleToFill
        button.setImage(UIImage(named: Constants.removeButton)!, for: .normal)
        button.isHidden = true
        return button
    }
}

class CustomLabel: UILabel {
    
    enum LabelTypes: String {
        case header, banner, title
        case season = "Season", allSeasons = "All seasons", episode = "Episode"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    convenience init(type: LabelTypes) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = UIFont.supplementaryItemsFont(size: 20, type: .normal)
        switch type {
        case .banner:
            backgroundColor = UIColor.detailVcBackgroundColor
            font = UIFont.systemFont(ofSize: 18)
            layer.masksToBounds = true
            layer.cornerRadius = 8
            textColor = UIColor.seriesBlackTextColor
        case .header:
            font = UIFont.supplementaryItemsFont(size: 23, type: .normal)
            textColor = .white
        case .title:
            numberOfLines = 0
            textAlignment = .center
            font = UIFont.supplementaryItemsFont(size: 20, type: .main)
            textColor = .black
            alpha = 0
        case .allSeasons, .season, .episode:
            text = type.rawValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

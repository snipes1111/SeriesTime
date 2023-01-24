//
//  Colors.swift
//  SerialTime
//
//  Created by user on 20/01/2023.
//

import Foundation
import UIKit

extension UIColor {
    static let detailVcBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let seriesBlackTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let collectionViewBackground = #colorLiteral(red: 0.1294117868, green: 0.1294117868, blue: 0.1294117868, alpha: 1)
}

extension UIFont {
    enum FontsType {
        case main, normal, title
    }
    
    static func supplementaryItemsFont(size: CGFloat, type: FontsType) -> UIFont {
        switch type {
        case .normal:
            return UIFont(name: "Noteworthy-Light", size: size)!
        case .main:
            return UIFont(name: "Georgia-Bold", size: size)!
        case .title:
            return UIFont(name: "Noteworthy-Bold", size: size)!
        }
    }
}

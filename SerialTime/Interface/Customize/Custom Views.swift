//
//  Custom Views.swift
//  SerialTime
//
//  Created by user on 20/01/2023.
//

import Foundation
import UIKit

extension UIView {
    static func roundAndShadowView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.detailVcBackgroundColor
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 3)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        return view
    }
}

extension UIImageView {
    static func seriesImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }
}

extension UIStackView {
    static func customStackView() -> UIStackView {
        let containerView = UIStackView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.alignment = .fill
        containerView.distribution = .equalSpacing
        containerView.spacing = 10
        containerView.axis = .vertical
        return containerView
    }
    
    func setUpSubViews() {
        arrangedSubviews.forEach { [unowned self] view in
            view.heightAnchor.constraint(equalToConstant: 30).isActive = true
            view.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        }
    }
}

class CustomUICollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(white: 0.85, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    static func customCompositionalLayout(view: UIView) -> UICollectionView {
        // making a conntainer with 3 squares
        let itemsPerRow: CGFloat = 2
        let fraction: CGFloat = 1 / itemsPerRow
        let insets: CGFloat = 16
        let figureWidth: CGFloat = (view.bounds.width - insets * 2 * (itemsPerRow - 1)) / itemsPerRow
        let sideInsets: CGFloat = view.bounds.width / 2 - figureWidth / 2
        // banner
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(30))
        let containerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0, y: 10))
        let bannerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize, elementKind: Constants.newBannner, containerAnchor: containerAnchor)
        bannerItem.zIndex = 2
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [bannerItem])
        item.contentInsets = NSDirectionalEdgeInsets(top: insets, leading: insets, bottom: insets, trailing: insets)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction * 1.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: insets, leading: sideInsets, bottom: insets, trailing: sideInsets)
        section.orthogonalScrollingBehavior = .continuous
        // background
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: Constants.backgroundId)
        let topInsert: CGFloat = 40
        let bottomInsert: CGFloat = 10
        let sideInserts: CGFloat = 5
        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: topInsert, leading: sideInserts, bottom: bottomInsert, trailing: sideInserts)
        section.decorationItems = [backgroundItem]
        // header
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let headeritem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: Constants.headerIdCell, alignment: .top)
        headeritem.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [headeritem]
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            //animation
            items.forEach { item in
                if item.representedElementKind != Constants.backgroundId {
                    let distanceForCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2)
                    let minScale: CGFloat = 0.7
                    let maxScale: CGFloat = 1.1
                    let scale = max(maxScale - (distanceForCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
        // layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(BackgroundSectionView.self, forDecorationViewOfKind: Constants.backgroundId)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.collectionViewBackground
        return collection
    }
}

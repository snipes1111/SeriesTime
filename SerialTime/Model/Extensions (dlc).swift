//
//  Extensions (dlc).swift
//  SerialTime
//
//  Created by user on 10/01/2023.
//

// infiniteLayout
//            let selectedSection: Int = offset.y < 50 ? 0 : 1
//            let lastItem = IndexPath(row: self.arrayOfSeries[selectedSection].count - 2, section: selectedSection)
//            let firstItem = IndexPath(row: 1, section: selectedSection)
//            let countOfitems = CGFloat(self.arrayOfSeries[selectedSection].count)
//            let spaceForOneItem = self.seriesCollectionView!.frame.width * fraction
//            let spacesNeededForScroll = countOfitems - itemsPerRow
//            let spaceForScroll = (spaceForOneItem * spacesNeededForScroll) + 20
//
//            print(spaceForScroll)
//
//
//            if offset.x > spaceForScroll + 70 {
//                self.seriesCollectionView?.scrollToItem(at: firstItem, at: .right, animated: false)
//            }
//
//            if offset.x < -50 {
//                self.seriesCollectionView?.scrollToItem(at: lastItem, at: .left, animated: false)
//            }

// change textAttributes
//        self.navigationController?.navigationBar.titleTextAttributes =

// MARK: - FlowLayoutDelegate
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let perItemInsets: CGFloat = 20
//        let itemsPerRow: CGFloat = 2
//        let insets = perItemInsets * (itemsPerRow + 1)
//        let availableSpace = view.bounds.width - insets
//        let itemSize = availableSpace / itemsPerRow
//        return CGSize(width: itemSize, height: itemSize)
//    }
// MARK: - header delegate
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 100, height: 0)
//    }

// MARK: - Header in flowLayout
//            if kind == UICollectionView.elementKindSectionHeader {
//                let headerCell = seriesCollectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerIdCell, for: indexPath) as! HeaderCollectionViewCell
//                return headerCell
//            }
//            assert(false, "Non type found")

// MARK: - create UICollectionViewFlowLayout
//func createCollectionViewFlowLayout() {
//    let perItemInsets: CGFloat = 20
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .vertical
//    layout.sectionInset = UIEdgeInsets(top: perItemInsets, left: perItemInsets, bottom: perItemInsets, right: perItemInsets)
//    layout.minimumLineSpacing = perItemInsets
//    layout.minimumInteritemSpacing = perItemInsets
//    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    collection.backgroundColor = #colorLiteral(red: 0.1294117868, green: 0.1294117868, blue: 0.1294117868, alpha: 1)
//    seriesCollectionView = collection
//}

//    // MARK: - customize navBar if needed
//    func makeNavBarNonTranslucent() {
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithDefaultBackground()
//        navBarAppearance.titleTextAttributes = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold),
//            NSAttributedString.Key.foregroundColor: UIColor.white
//        ]
//        navigationItem.scrollEdgeAppearance = navBarAppearance
//        navigationItem.standardAppearance = navBarAppearance
//        navigationItem.compactAppearance = navBarAppearance
//    }

// MARK: - shadow UIBezierPath
//func makeRoundedAndShadowed() {
//    let shadowLayer = CAShapeLayer()
//    shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
//    shadowLayer.shadowPath = shadowLayer.path
//    shadowLayer.fillColor = self.backgroundColor?.cgColor
//    shadowLayer.shadowColor = UIColor.black.cgColor
//    shadowLayer.shadowOffset = .init(width: 0, height: 3)
//    shadowLayer.shadowOpacity = 1
//    shadowLayer.shadowRadius = 4
//    self.backgroundColor = UIColor.detailVcBackgroundColor
//    self.layer.insertSublayer(shadowLayer, at: 0)
//    self.layer.cornerRadius = 40
//    self.layer.masksToBounds = false
//}

//class AutoSizeTextField: UITextField {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        for subview in subviews {
//            if let label = subview as? UILabel {
//                label.minimumScaleFactor = 0.3
//                label.adjustsFontSizeToFitWidth = true
//            }
//        }
//    }
//}

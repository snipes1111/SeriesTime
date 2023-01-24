//
//  ViewController.swift
//  SerialTime
//
//  Created by user on 29/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var seriesCollectionView: UICollectionView?
    var arrayOfSeries = SeriesItems.arrayOfAllSeries
    var selectedCell: SeriesDescriptionCell?
    private let transitionManager = TransitionManager(duration: 0.5)
    var editingForDelete: Bool = false
    var mainUserSettings = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionViewCompositionalLayout()
        makeConstraints()
        setUpNavBar()
        addLongPressToCollectionView()
        navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

// MARK: - Making interface
extension ViewController {
    
    // MARK: - Set up navbar
    func setUpNavBar() {
        // title
        title = Constants.mainVCTitle
        navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.supplementaryItemsFont(size: 30, type: .title)
        ]
        // backButton
        navigationController?.navigationBar.backIndicatorImage = UIImage.customBackImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.customBackImage()
        navigationItem.backButtonTitle = Constants.backButton
        navigationController?.navigationBar.tintColor = .black
        // custom edit button
        let editButton = editButtonItem
        editButton.tintColor = .white
        editButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.supplementaryItemsFont(size: 15, type: .title)], for: .normal)
        navigationItem.rightBarButtonItem = editButton
    }
    
    // MARK: - create UICollectionViewCompositionalLayout
    func createCollectionViewCompositionalLayout() {
        seriesCollectionView = UICollectionView.customCompositionalLayout(view: view)
        seriesCollectionView?.register(SeriesDescriptionCell.self, forCellWithReuseIdentifier: Constants.celId)
        seriesCollectionView?.delegate = self
        seriesCollectionView?.dataSource = self
        view.addSubview(seriesCollectionView!)
        // MARK: - register header cell
        seriesCollectionView?.register(HeaderCollectionViewCell.self,
                                       forSupplementaryViewOfKind: Constants.headerIdCell,
                                       withReuseIdentifier: Constants.headerIdCell)
        seriesCollectionView?.register(EpisodeBanner.self,
                                       forSupplementaryViewOfKind: Constants.newBannner,
                                       withReuseIdentifier: Constants.newBannner)
        
        // MARK: - Move items to middle
        if let section = seriesCollectionView?.numberOfSections {
            for i in 0..<section {
                let items = arrayOfSeries[i]
                let middle = Int(items.count / 2)
                let indexPath = IndexPath(item: middle, section: i)
                self.seriesCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    // MARK: - create constraints of collectionLayout
    func makeConstraints() {
        seriesCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        seriesCollectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        seriesCollectionView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        seriesCollectionView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        seriesCollectionView?.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - set up datasource and delegate of collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfSeries[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayOfSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let seriesCell = seriesCollectionView?.dequeueReusableCell(withReuseIdentifier: Constants.celId, for: indexPath) as? SeriesDescriptionCell
        else { return UICollectionViewCell() }
        seriesCell.delegate = self
        seriesCell.deleteButton.isHidden = !editingForDelete
        seriesCell.deleteButton.alpha = 1
        let episode = arrayOfSeries[indexPath.section]
        seriesCell.episode = episode[indexPath.row]
        return seriesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let newSelectedCell = seriesCollectionView?.cellForItem(at: indexPath) as? SeriesDescriptionCell {
            selectedCell = newSelectedCell
        }
        let series = arrayOfSeries[indexPath.section]
        let episode = series[indexPath.item]
        let detailVC = DetailViewController()
        detailVC.configure(with: episode)
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        let indexPathes = seriesCollectionView!.indexPathsForVisibleItems
        editingForDelete = editing
        for indexPath in indexPathes {
            let cell = seriesCollectionView!.cellForItem(at: indexPath) as! SeriesDescriptionCell
            switch editing {
            case true:
                cell.deleteButton.alpha = 0
                cell.deleteButton.isHidden = !editing
                UIView.animate(withDuration: 0.2) {
                    cell.deleteButton.alpha = 1
                } completion: { finished in
                    self.seriesCollectionView?.reloadData()
                }
            case false:
                UIView.animate(withDuration: 0.2) {
                    cell.deleteButton.alpha = 0
                } completion: { finished in
                    self.seriesCollectionView?.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = arrayOfSeries[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        arrayOfSeries[destinationIndexPath.section].insert(item, at: destinationIndexPath.item)
        
    }
    
    func addLongPressToCollectionView() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(gesture:)))
        seriesCollectionView?.addGestureRecognizer(longPress)
    }
    
    @objc func longPressGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = seriesCollectionView?.indexPathForItem(at: gesture.location(in: seriesCollectionView)) else { return }
            seriesCollectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            seriesCollectionView?
                .updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            seriesCollectionView?.endInteractiveMovement()
           
        default:
            seriesCollectionView?.cancelInteractiveMovement()
           
        }
    }
    
    
    // MARK: - Customize collectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = arrayOfSeries[indexPath.section]
        var episode = section[indexPath.item]
        let key = episode.name!
        switch kind {
        case Constants.headerIdCell:
            guard let headerView = seriesCollectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerIdCell, for: indexPath) as? HeaderCollectionViewCell else { return UICollectionReusableView() }
            switch indexPath.section {
            case 0:
                headerView.textLabel.text = Constants.seriesInProgress
            case 1:
                headerView.textLabel.text = Constants.seriesFinished
            default:
                headerView.textLabel.text = ""
            }
            return headerView
        case Constants.newBannner:
            guard let bannerView = seriesCollectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.newBannner, for: indexPath) as? EpisodeBanner else { return UICollectionReusableView() }
            if let seasonText = mainUserSettings.object(forKey: "\(key).season") as? String,
               let episodeText = mainUserSettings.object(forKey: "\(key).episode") as? String {
                episode.episode = Int(episodeText) ?? 1
                episode.season = Int(seasonText) ?? 1
            }
            bannerView.episode = episode
            return bannerView
        default:
            assertionFailure("Unexpected element kind: \(kind).")
            return UICollectionReusableView()
        }
    }
    
    // make title change color
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distanceToTop = -scrollView.contentOffset.y
        guard let navBarMaxY = self.navigationController?.navigationBar.frame.maxY else { return }
        UIView.animate(withDuration: 0.5) {
            if navBarMaxY < distanceToTop + 0.05 {
                self.navigationController?.navigationBar.titleTextAttributes = [
                    .foregroundColor: UIColor.white,
                    .font : UIFont.supplementaryItemsFont(size: 30, type: .title)]
            } else {
                self.navigationController?.navigationBar.titleTextAttributes = [
                    .foregroundColor: UIColor.black,
                    .font : UIFont.supplementaryItemsFont(size: 30, type: .title)]
            }
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
}

extension ViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push { return transitionManager }
        return nil
    }
}

extension ViewController: PhotoCellDelegate {
    
    func delete(cell: SeriesDescriptionCell) {
        if let indexPath = seriesCollectionView?.indexPath(for: cell) {
            arrayOfSeries[indexPath.section].remove(at: indexPath.item)
            seriesCollectionView?.deleteItems(at: [indexPath])
        }
    }
}

extension ViewController: DetailViewControllerDelegate {
    func refreshData(detailVC: DetailViewController) {
        seriesCollectionView?.reloadData()
    }
    
    
}

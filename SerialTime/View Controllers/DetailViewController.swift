//
//  DetailViewController.swift
//  SerialTime
//
//  Created by user on 11/01/2023.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func refreshData(detailVC: DetailViewController)
}

class DetailViewController: UIViewController {
    // save settings
    var keyForDetailVC: String = ""
    let userSettings = UserDefaults.standard
    weak var delegate: DetailViewControllerDelegate?
    // interface
    var headerView = UIView.roundAndShadowView()
    var imageView = UIImageView.seriesImageView()
    let labelName: UILabel = CustomLabel(type: .title)
    let picker = UIPickerView()
    // labels
    let descriptionLabels = [CustomLabel(type: .season),
                             CustomLabel(type: .episode),
                             CustomLabel(type: .allSeasons)]
    // textfields
    let descriptionTextfields = [MyCustomTextField(type: .season),
                                 MyCustomTextField(type: .episode),
                                 MyCustomTextField(type: .allSeasons)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadChanges()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.refreshData(detailVC: self)
    }
    
}

extension DetailViewController {
    func configure(with episode: Series) {
        guard let imageName = episode.image else { return }
        guard let image = UIImage(named: imageName) else { return }
        guard let text = episode.name else { return }
        imageView.image = image
        labelName.text = text
        keyForDetailVC = text
    }
    
    func loadChanges() {
        
        UIView.animate(withDuration: 0.6) {
            self.labelName.alpha = 1
        }
        
        guard let season = userSettings.object(forKey: "\(keyForDetailVC).season") as? String,
              let episode = userSettings.object(forKey: "\(keyForDetailVC).episode") as? String,
              let allSeries = userSettings.object(forKey: "\(keyForDetailVC).allSeries") as? String
        else { return }
        
        for textFields in descriptionTextfields {
            switch textFields.type {
            case .allSeasons:
                textFields.text = allSeries
            case .episode:
                textFields.text = episode
            case .season:
                textFields.text = season
            }
        }
        
    }
    
    func setUI() {
        
        descriptionTextfields.forEach { textfield in
            textfield.delegate = self
        }
        
        let containerView = UIStackView.customStackView()
        for label in descriptionLabels {
            containerView.addArrangedSubview(label)
        }
    
        let containerViewForTF = UIStackView.customStackView()
        for textfield in descriptionTextfields {
            containerViewForTF.addArrangedSubview(textfield)
        }
        
        containerView.setUpSubViews()
        containerViewForTF.setUpSubViews()
        
        let views = [containerView, containerViewForTF, headerView, labelName]
        for view in views {
            self.view.addSubview(view)
        }
        self.headerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            
            imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, constant: 0),
            
            labelName.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            labelName.bottomAnchor.constraint(greaterThanOrEqualTo: headerView.topAnchor, constant: -30),
            labelName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            labelName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            containerViewForTF.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            containerViewForTF.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 50),
            containerViewForTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerViewForTF.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currentTF = textField as? MyCustomTextField else { return }
        switch currentTF.type {
        case .season:
            userSettings.set(textField.text, forKey: "\(keyForDetailVC).season")
        case .episode:
            userSettings.set(textField.text, forKey: "\(keyForDetailVC).episode")
        case .allSeasons:
            userSettings.set(textField.text, forKey: "\(keyForDetailVC).allSeries")
        }
    }
}


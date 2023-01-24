//
//  SeriesDescriptionCell.swift
//  SerialTime
//
//  Created by user on 29/12/2022.
//

import UIKit

protocol PhotoCellDelegate: AnyObject {
    func delete(cell: SeriesDescriptionCell)
}

class SeriesDescriptionCell: CustomCollectionViewCell {
    
    weak var delegate: PhotoCellDelegate?
    
    public let imageView = UIImageView.seriesImageView()
    public let deleteButton = UIButton.editButton()
    
    public var episode: Series? {
        didSet {
            guard let image = UIImage(named: episode?.image ?? "") else { return }
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSelf()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeriesDescriptionCell {
  
    func configureSelf() {
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    
    func makeConstraints() {
        imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10).isActive = true
        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func deleteButtonDidTap() {
        delegate?.delete(cell: self)
    }
}


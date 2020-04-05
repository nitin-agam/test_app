//
//  FactListTableCell.swift
//  TestApp
//
//  Created by Nitin A on 05/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit
import SDWebImage

class FactListTableCell: BaseTableCell {

    static let thumbnailBackColor = UIColor(white: 0, alpha: 0.1)
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
    private let thumbnail: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = FactListTableCell.thumbnailBackColor
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var fact: FactModel? {
        didSet {
            guard let model = fact else { return }
            
            // if image not exists due to any reason then showing back color
            if let imageUrl = URL(string: model.imageHref ?? "") {
                self.thumbnail.backgroundColor = FactListTableCell.thumbnailBackColor
                self.thumbnail.sd_setImage(with: imageUrl,
                                                    placeholderImage: nil,
                                                    options: .avoidAutoSetImage)
                { [weak self] (image, error, _, url) in
                    if let self = self {
                        
                        if let _ = error {
                            self.thumbnail.backgroundColor = FactListTableCell.thumbnailBackColor
                            return
                        }
                        
                        // check the image for correct url before setting it
                        if let thumbnailImage = image, url?.absoluteString == model.imageHref {
                            self.thumbnail.image = thumbnailImage
                            self.thumbnail.backgroundColor = .clear
                        } else {
                            self.thumbnail.backgroundColor = FactListTableCell.thumbnailBackColor
                        }
                    }
                }
            } else {
                self.thumbnail.backgroundColor = FactListTableCell.thumbnailBackColor
            }
            
            
            let attributedText = NSMutableAttributedString()
            if let title = model.title, title.isEmpty == false {
                attributedText.append(NSAttributedString(string: title,
                                                         attributes: [.font: UIFont.boldSystemFont(ofSize: 18),
                                                                      .foregroundColor: UIColor.black]))
            }
            
            if let description = model.description, description.isEmpty == false {
                
                if let title = model.title, title.isEmpty == false {
                    // make a small vertical space between title and description
                    attributedText.append(NSAttributedString(string: "\n\n",
                                                             attributes: [.font: UIFont.boldSystemFont(ofSize: 4)]))
                }
                
                attributedText.append(NSAttributedString(string: description,
                                                         attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                      .foregroundColor: UIColor.gray]))
            }
            
            infoLabel.attributedText = attributedText
        }
    }
    
    override func initialSetup() {
        
        // to set minimum height for this cell to display image properly.
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 124).isActive = true
        
        addSubviews(thumbnail, infoLabel)
        thumbnail.makeConstraints(top: topAnchor, left: nil, right: rightAnchor, bottom: nil, topMargin: 12, leftMargin: 0, rightMargin: 12, bottomMargin: 0, width: 150, height: 100)
        infoLabel.makeConstraints(top: topAnchor, left: leftAnchor, right: thumbnail.leftAnchor, bottom: bottomAnchor, topMargin: 12, leftMargin: 12, rightMargin: 8, bottomMargin: 12, width: 0, height: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // removing previous data from cell object, so cell will use updated info to display
        infoLabel.attributedText = nil
        thumbnail.image = nil
        fact = nil
    }
}

//
//  MapButtonView.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/9/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

class MapButtonView: UIView {
    
    var mainImageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "")
        view.image = image?.imageWithInsets(insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.tintColor = Theme.Colors.hintGray.color
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = Constants.Strings.searchAgain
        label.textColor = Theme.Colors.primaryText.color
        label.font = Theme.Fonts.primary.font
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() {
        backgroundColor = Theme.Colors.background.color
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
        dropShadow(color: Theme.Colors.dropShadowDark.color, opacity: 1, offSet: CGSize(width: -2, height: 2), radius: 5, scale: true)
        
        //mainImageView
        addSubview(mainImageView)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: mainImageView)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: mainImageView)
        mainImageView.layer.cornerRadius = layer.cornerRadius
        
        //titleLabel
        addSubview(titleLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:[v0]", views: titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}

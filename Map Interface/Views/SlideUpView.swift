//
//  SlideUpView.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/9/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

class SlideUpView: UIView {
    
    let horizontalLineView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_horizontal_line")
        return view
    }()
    let utility = AppUtility.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: UI
    
    func setupSubViews() {
        backgroundColor = Theme.Colors.reallyWhite.color
        dropShadow()
        
        //horizontalLine
        addSubview(horizontalLineView)
        addConstraintsWithFormat(format: "H:[v0(\(Constants.Sizes.horizontalLineView.width))]", views: horizontalLineView)
        addConstraintsWithFormat(format: "V:|[v0(\(Constants.Sizes.horizontalLineView.height))]", views: horizontalLineView)
        addConstraint(NSLayoutConstraint(item: horizontalLineView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
}

//
//  SideViewManager.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/9/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

class SideViewManager: NSObject {
    
    let darkView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        view.backgroundColor = Theme.Colors.backgroundBlack.color.withAlphaComponent(0.3)
        view.alpha = 0.0
        return view
    }()
    let profileSideView: SideView = {
        let view = SideView(frame: CGRect(x: UIScreen.main.bounds.origin.x - Constants.Sizes.sideView.width, y: 0, width: Constants.Sizes.sideView.width, height: Constants.Sizes.sideView.height))
        return view
    }()
    var vc: UIViewController!
    var subviewAdded: Bool = false
    let utility = AppUtility.sharedInstance
    
    override init() {
        super.init()
        checkForSubView()
    }
    
    func checkForSubView() {
        if !subviewAdded {
            if let controller = vc {
                controller.view.addSubview(darkView)
                controller.view.addSubview(profileSideView)
                subviewAdded = true
                addGestures()
            }
        }
    }
    
    
    //MARK: Actions
    
    func addGestures() {
        
        //profileSideView
        profileSideView.isUserInteractionEnabled = true
        let dismissPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        profileSideView.addGestureRecognizer(dismissPanGesture)
        
        //darkView
        darkView.isUserInteractionEnabled = true
        let dismissDarkPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        let dismissDarkTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleDarkViewTapped))
        darkView.gestureRecognizers = [dismissDarkTapGesture, dismissDarkPanGesture]
    }
    
    func show() {
        checkForSubView()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.profileSideView.frame.origin.x = UIApplication.shared.keyWindow?.frame.origin.x ?? 0
            self.darkView.alpha = 1.0
            self.utility.hideStatusBar(true)
        }, completion: { (true) in
            
        })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.profileSideView.frame.origin.x = UIScreen.main.bounds.origin.x - self.profileSideView.frame.size.width
            self.darkView.alpha = 0.0
            self.utility.hideStatusBar(false)
        }, completion: { (true) in
            
        })
    }
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: profileSideView)
        if sender.state == UIGestureRecognizerState.began {
            
        } else if sender.state == UIGestureRecognizerState.ended {
            if((self.profileSideView.frame.origin.x + self.profileSideView.frame.size.width) > UIScreen.main.bounds.size.width / 2) {
                //back to visible standard view
                sender.setTranslation(CGPoint.zero, in: self.profileSideView)
                self.show()
                return
            } else {
                //hide
                self.hide()
                return
            }
        } else if sender.state == UIGestureRecognizerState.changed {
            let maxX = (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width - self.profileSideView.frame.size.width))
            let lessThanMaxX = (self.profileSideView.frame.maxX + translation.x) <= maxX
            if(lessThanMaxX) {
                //set center of view to new dragged point
                self.profileSideView.center = CGPoint(x: self.profileSideView.center.x + translation.x, y: self.profileSideView.center.y)
                sender.setTranslation(CGPoint.zero, in: self.profileSideView)
            }
        }
    }
    
    @objc func handleDarkViewTapped() {
        hide()
    }
}

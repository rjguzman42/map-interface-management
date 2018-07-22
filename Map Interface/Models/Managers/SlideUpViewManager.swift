//
//  SlideUpViewManager.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/9/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

class SlideUpViewManager: NSObject {
    
    lazy var slideUpView: SlideUpView = {
        let view = SlideUpView(frame: CGRect(x: UIScreen.main.bounds.origin.x, y: minimizeOrigin, width: Constants.Sizes.slideUpView.width, height: Constants.Sizes.slideUpView.height))
        return view
    }()
    let maxOrigin: CGFloat = 0
    let previewOrigin: CGFloat = UIScreen.main.bounds.size.height - Constants.Sizes.slideUpViewPreview.height
    lazy var previewOriginExtra: CGFloat = self.previewOrigin + 100
    let minimizeOrigin: CGFloat = UIScreen.main.bounds.size.height - Constants.Sizes.slideUpViewMinimized.height
    var vc: UIViewController!
    var attachedViews: [UIView] = []
    var subviewAdded: Bool = false
    let utility = AppUtility.sharedInstance
    
    override init() {
        super.init()
        checkForSubView()
    }
    
    
    //MARK: UI
    
    func checkForSubView() {
        if !subviewAdded {
            if let controller = vc {
                controller.view.addSubview(slideUpView)
                subviewAdded = true
                addGestures()
            }
        }
    }
    
    
    //MARK: Actions
    
    func addGestures() {
        
        //slideUpView
        slideUpView.isUserInteractionEnabled = true
        let dismissPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        slideUpView.addGestureRecognizer(dismissPanGesture)
        
    }
    
    func show(origin: CGFloat = (UIScreen.main.bounds.size.height / 2) + 100) {
        checkForSubView()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            for attachedView in self.attachedViews {
                attachedView.frame.origin.y = origin - attachedView.frame.size.height - 10
            }
            self.slideUpView.frame.origin.y = origin
            if origin == self.maxOrigin {
                self.utility.hideStatusBar(true)
            }
        }, completion: { (true) in
            
        })
    }
    
    func minimize() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            for attachedView in self.attachedViews {
                attachedView.frame.origin.y = self.minimizeOrigin - attachedView.frame.size.height - 10
            }
            self.slideUpView.frame.origin.y = self.minimizeOrigin
        }, completion: { (true) in
            
        })
    }
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: slideUpView)
        if sender.state == UIGestureRecognizerState.began {
            
        } else if sender.state == UIGestureRecognizerState.ended {
            if self.slideUpView.frame.origin.y > previewOriginExtra {
                //minimize
                self.minimize()
            } else if self.slideUpView.frame.origin.y > previewOrigin {
                //preview
                self.show(origin: self.previewOrigin)
            } else {
                let draggingDown: Bool = sender.velocity(in: slideUpView).y > 0
                if draggingDown {
                    //preview
                    self.show(origin: self.previewOrigin)
                } else {
                    //show maxView
                    self.show(origin: self.maxOrigin)
                }
            }
            
           
            sender.setTranslation(CGPoint.zero, in: self.slideUpView)
            return
        } else if sender.state == UIGestureRecognizerState.changed {
            let lessThanMaxX = (self.slideUpView.frame.origin.y + translation.y) <= minimizeOrigin
            let greaterThanWindowOrigin = self.slideUpView.frame.origin.y > UIScreen.main.bounds.origin.y
            let equalToWindowOrigin = self.slideUpView.frame.origin.y == UIScreen.main.bounds.origin.y
            let draggingDown: Bool = translation.y > 0
            if ((lessThanMaxX && greaterThanWindowOrigin) || (equalToWindowOrigin && draggingDown)) {
                //set center of view to new dragged point
                self.slideUpView.center = CGPoint(x: self.slideUpView.center.x, y: self.slideUpView.center.y + translation.y)
                for attachedView in self.attachedViews {
                    attachedView.center = CGPoint(x: attachedView.center.x, y: attachedView.center.y + translation.y)
                }
            } 
            sender.setTranslation(CGPoint.zero, in: self.slideUpView)
        }
    }
    
}

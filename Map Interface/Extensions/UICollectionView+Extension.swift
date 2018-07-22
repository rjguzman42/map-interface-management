//
//  UICollectionView+Extension.swift
//  chefspot
//
//  Created by Roberto Guzman on 7/16/18.
//  Copyright © 2018 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func getFittedSizeForItem(numberOfColumns: Int) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let contentInset = (self.contentInset.left + self.contentInset.right)
        let inset = Int(contentInset == -1 ? -1 : contentInset)
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfColumns + inset))
        let size = Int((bounds.width - totalSpace) / CGFloat(numberOfColumns))
        return CGSize(width: size, height: size)
    }
}

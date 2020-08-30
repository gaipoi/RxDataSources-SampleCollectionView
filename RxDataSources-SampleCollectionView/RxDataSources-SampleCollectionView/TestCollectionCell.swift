//
//  CollectionCell.swift
//  RxDataSources-SampleCollectionView
//
//  Created by Gaiki Ito on 2020/08/28.
//  Copyright © 2020 Gaiki Ito. All rights reserved.
//

import Foundation
import UIKit

final class TestCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var sampleTitlelabel: UILabel!
    
    func configureCell(title: String) {
        sampleTitlelabel.text = title
    }
}

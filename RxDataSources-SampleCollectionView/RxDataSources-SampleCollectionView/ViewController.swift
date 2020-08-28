//
//  ViewController.swift
//  RxDataSources-SampleCollectionView
//
//  Created by Gaiki Ito on 2020/08/28.
//  Copyright © 2020 Gaiki Ito. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: TestViewModel = TestViewModel()
    private let disposeBag = DisposeBag()
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<TestSectionModel>(configureCell: configureCell)
    private lazy var configureCell: RxCollectionViewSectionedReloadDataSource<TestSectionModel>.ConfigureCell = {[weak self] (_, collectionView, indexPath, item) in
        return (self?.configureCell(collectionView, item: item, indexPath: indexPath) ?? UICollectionViewCell())
    }

    private let reuseIdentifier = "CollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        bindingItems()
    }
    
    private func configureCell(_ collectionView: UICollectionView, item: TestSectionItemType, indexPath: IndexPath) -> UICollectionViewCell? {
        switch item {
        case .testCell(let title):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionCell {
                // cell.titleLabel.text = title
                return cell
            }
            return nil
        }
    }
    
    private func registerNibs() {
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func bindingItems() {
        viewModel.items
            .asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}


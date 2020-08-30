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

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: TestViewModel = TestViewModel()
    private let disposeBag = DisposeBag()
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<TestSectionModel>(configureCell: configureCell)
    private lazy var configureCell: RxCollectionViewSectionedReloadDataSource<TestSectionModel>.ConfigureCell = {[weak self] (_, collectionView, indexPath, item) in
        return (self?.cell(collectionView, item: item, indexPath: indexPath) ?? UICollectionViewCell())
    }

    private let reuseIdentifier = "TestCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        registerNibs()
        bindingItems()
    }
    
    private func cell(_ collectionView: UICollectionView, item: TestSectionItemType, indexPath: IndexPath) -> UICollectionViewCell? {
        switch item {
        case .testCell(let title):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TestCollectionCell {
                cell.configureCell(title: title)
                return cell
            }
            return nil
        }
    }
    
    private func registerNibs() {
        collectionView.register(TestCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func bindingItems() {
        viewModel.items
            .asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = dataSource[section]
        switch section.model {
        case .testSection: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 375.0, height: 150.0)
    }
}


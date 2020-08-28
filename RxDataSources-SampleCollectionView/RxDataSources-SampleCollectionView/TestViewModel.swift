//
//  TestViewModel.swift
//  RxDataSources-SampleCollectionView
//
//  Created by Gaiki Ito on 2020/08/28.
//  Copyright © 2020 Gaiki Ito. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias TestSectionModel = SectionModel<TestSectionType, TestSectionItemType>

enum TestSectionType { case testSection }
enum TestSectionItemType { case testCell(title: String) }

final class TestViewModel {
    var items = BehaviorRelay<[TestSectionModel]>(value: [])

    init() {
        // 通信処理が必要な場合、通信を監視し、完了してからconfigureItems()を呼ぶのが良いと思います
        configureItems()
    }

    private func configureItems() {
        var sections: [TestSectionModel] = []
        var cellItems: [TestSectionItemType] = []

        cellItems.append(.testCell(title: "タイトル"))
        sections.append(TestSectionModel(model: .testSection, items: cellItems))

        items.accept(sections)
    }
}

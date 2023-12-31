//
//  CategoryCell.swift
//  TestFood
//
//  Created by Bach Nghiem on 09/10/2023.
//

import RxSwift
import RxCocoa
import Reusable

protocol CategoryCellDelegate: AnyObject {
    func clickItem(category: Category)
}

final class CategoryCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var subCategoryLabel: UILabel!
    private let disposeBag = DisposeBag()
    weak var delegate: CategoryCellDelegate?
    var categories = [Category]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: Constant.Space.widthCellCategory, height: Constant.Space.heightCellCategory)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: ItemCategoryCell.self)
        let _ = collectionView.rx.itemSelected
            .map { indexPath in
                return self.categories[indexPath.item]
            }
            .subscribe(onNext: { category in
                self.delegate?.clickItem(category: category)
            })
            .disposed(by: disposeBag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCellWith(categories: [Category]) {
        self.categories = categories
        self.collectionView.reloadData()
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ItemCategoryCell.self)
        cell.configCell(category: categories[indexPath.row])
        return cell
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constant.Space.marginZero, left: Constant.Space.marginMedium, bottom: Constant.Space.marginZero, right: Constant.Space.marginMedium)
    }
}

//
//  FavouriteViewController.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 17/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Alamofire

final class FavouriteViewController: UIViewController, Bindable {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: FavouriteViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.do {
            $0.register(cellType: FoodCategoryCell.self)
        }
    }
    
    func configView() {
        title = L10n.favourite
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        let loadTrigger = Driver.just(())
        let input = FavouriteViewModel.Input(
            load: loadTrigger
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
        output.favouriteFoods.drive(tableView.rx.items) { tableView, index, foodEntity in
            let indexPath = IndexPath(item: index, section: 0)
            let food = Food.convertToFood(foodEntity: foodEntity)
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FoodCategoryCell.self).then {
                $0.configCell(food: food)
            }
            return cell
        }
        .disposed(by: disposeBag)
    }
    
}

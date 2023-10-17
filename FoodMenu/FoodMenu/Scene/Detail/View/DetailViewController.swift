//
//  DetailViewController.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 12/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Alamofire
import Then

final class DetailViewController: UIViewController, Bindable {
    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var orderButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var caloryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var thumnailImageView: UIImageView!
    
    var viewModel: DetailViewModel!
    private let disposeBag = DisposeBag()
    var isFavourite = false
    private var id: String?
    private var food: Food?
    private let saveFavouriteTrigger = PublishSubject<Food>()
    private let deleteFavouriteTrigger = PublishSubject<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        title = L10n.detailFood
        favouriteButton.setRoundedFavouriteButton()
        orderButton.then {
            $0.setRounded(radius: Constant.Space.normalRadius)
            $0.setFontSize(size: Constant.Space.textSizeNormal)
        }
    }
    
    func bindViewModel() {
        let input = DetailViewModel.Input (
            load: Driver.just(()),
            name: nameTextField.rx.text.orEmpty.asDriver(),
            orderTrigger: orderButton.rx.tap.asDriver(),
            saveFavouriteTrigger: saveFavouriteTrigger.asDriver(onErrorDriveWith: .empty()),
            deleteFavouriteTrigger: deleteFavouriteTrigger.asDriver(onErrorDriveWith: .empty())
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        output.order.drive(onNext: { [weak self] food in
            self?.then { viewController in
                viewController.showAlert(title: L10n.thanks, message: L10n.orderSuccess, buttonTitle: L10n.ok)
                viewController.nameTextField.text = ""
            }
        })
        .disposed(by: disposeBag)
        
        output.food
            .drive(foodBinding)
            .disposed(by: disposeBag)
        
        output.isFavourite
            .drive(favouriteBinding)
            .disposed(by: disposeBag)
        
        output.saveFavourite
            .drive()
            .disposed(by: disposeBag)
        
        output.deleteFavourite
            .drive()
            .disposed(by: disposeBag)
    }
    @IBAction private func handleFavouriteButton(_ sender: Any) {
        guard let id = self.id,
              let food = self.food else { return }
        isFavourite ? deleteFavouriteTrigger.onNext(id) : saveFavouriteTrigger.onNext(food)
        isFavourite.toggle()
        self.configFavouriteButton()
    }
}

extension DetailViewController {
    var foodBinding: Binder<Food> {
        return Binder(self) { viewController, food in
            let url = URL(string: food.image)
            viewController.then {
                $0.food = food
                $0.id = food.id
                $0.thumnailImageView.sd_setImage(with: url, completed: nil)
                $0.caloryLabel.text = String(food.calories) + " " + L10n.calories
                $0.descriptionLabel.text = food.description
                $0.nameLabel.text = food.name
            }
        }
    }
    
    private var favouriteBinding: Binder<Bool> {
        return Binder(self) { viewController, isFavourite in
            viewController.do {
                $0.isFavourite = isFavourite
                $0.configFavouriteButton()
            }
        }
    }
    
    private func configFavouriteButton() {
        self.do {
            let image = isFavourite ? L10n.inFavouriteIcon : L10n.favouriteIcon
            let title = isFavourite ? L10n.addToFavouriteList: L10n.removeToFavouriteList
            $0.showAlert(title: L10n.thanks, message: title, buttonTitle: L10n.ok)
            $0.favouriteButton.setImage(UIImage(systemName: image),for: .normal)
        }
    }
}

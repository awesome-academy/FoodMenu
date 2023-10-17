//
//  DetailViewModel.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 12/10/2023.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct DetailViewModel {
    let useCase: DetailUseCaseType
    let navigator: DetailNavigatorType
    let food: Food
}

extension DetailViewModel: ViewModelType {
    struct Input {
        let load: Driver<Void>
        let name: Driver<String>
        let orderTrigger: Driver<Void>
        let saveFavouriteTrigger: Driver<Food>
        let deleteFavouriteTrigger: Driver<String>
    }
    
    struct Output {
        let food: Driver<Food>
        let isOrder: Driver<Bool>
        let isFavourite: Driver<Bool>
        let order: Driver<OrderResponse>
        let saveFavourite: Driver<Void>
        let deleteFavourite: Driver<Void>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let indicator = ActivityIndicator()
        let result = input.orderTrigger
            .withLatestFrom(input.name)
            .map { keyword in
                OrderRequest(keyword: food.id ?? "", request: Request(name: keyword))
            }
            .flatMap { inputRequest in
                self.useCase.placeOrder(input: inputRequest)
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn: OrderResponse())
            }
        let isFavourite = input.load
            .flatMapLatest {
                return self.useCase.checkFavouriteExist(id: food.id)
                    .asDriver(onErrorDriveWith: .empty())
            }
        
        let saveFavourite = input.saveFavouriteTrigger
            .flatMapLatest { food in
                return self.useCase.saveFavourite(food: food)
                    .asDriver(onErrorDriveWith: .empty())
            }
        
        let deleteFavourite = input.deleteFavouriteTrigger
            .flatMapLatest { id in
                return self.useCase.deleteFavourite(id: id)
                    .asDriver(onErrorDriveWith: .empty())
            }
        
        let foodItem = input.load
            .map { _ in
                return self.food
            }
        
        
        return Output(
            food: foodItem,
            isOrder: indicator.asDriver(),
            isFavourite: isFavourite,
            order: result,
            saveFavourite: saveFavourite,
            deleteFavourite: deleteFavourite
        )
    }
}



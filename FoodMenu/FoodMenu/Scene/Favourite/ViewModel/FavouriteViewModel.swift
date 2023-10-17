//
//  FavouriteViewModel.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 17/10/2023.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxSwiftUtilities

struct FavouriteViewModel {
    let useCase: FavouriteUseCaseType
    let navigator: FavouriteNavigatorType
}

extension FavouriteViewModel: ViewModelType {
    struct Input {
        let load: Driver<Void>
    }
    
    struct Output {
        var isLoading: Driver<Bool>
        let favouriteFoods: Driver<[FoodEntity]>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let indicator = ActivityIndicator()
        let favouriteFoods = input.load
            .flatMapLatest {
                return self.useCase.getAllFavourites()
                    .trackActivity(indicator)
                    .asDriver(onErrorJustReturn: [])
            }
        return Output(isLoading: indicator.asDriver(), favouriteFoods: favouriteFoods)
    }
}

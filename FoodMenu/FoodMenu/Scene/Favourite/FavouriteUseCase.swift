//
//  FavouriteUseCase.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 17/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavouriteUseCaseType {
    func getAllFavourites() -> Observable<[FoodEntity]>
    func deleteFavourite(id: String) -> Observable<Void>
}

struct FavouriteUseCase: FavouriteUseCaseType {
    func getAllFavourites() -> Observable<[FoodEntity]> {
        return CoreDataRepositoryImpl().getAllFavourites()
    }

    func deleteFavourite(id: String) -> Observable<Void> {
        return CoreDataRepositoryImpl().deleteFavourite(id: id)
    }
}

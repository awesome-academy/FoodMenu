//
//  DetailUseCase.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 12/10/2023.
//

import Foundation
import RxSwift

protocol DetailUseCaseType {
    func placeOrder(input: OrderRequest) -> Observable<OrderResponse>
    func saveFavourite(food: Food) -> Observable<Void>
    func checkFavouriteExist(id: String) -> Observable<Bool>
    func deleteFavourite(id: String) -> Observable<Void>
}

struct DetailUseCase: DetailUseCaseType {
    func saveFavourite(food: Food) -> Observable<Void> {
        return CoreDataRepositoryImpl().saveFavourite(food: food)
    }
    
    func checkFavouriteExist(id: String) -> Observable<Bool> {
        return CoreDataRepositoryImpl().checkFavouriteExist(id: id)
    }
    
    func deleteFavourite(id: String) -> Observable<Void> {
        return CoreDataRepositoryImpl().deleteFavourite(id: id)
    }
    
    func placeOrder(input: OrderRequest) -> Observable<OrderResponse> {
        return OrderRepositoryImpl().orderFood(input: input)
    }
}



//
//  CoreDataReposiitory.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 17/10/2023.
//

import UIKit
import Foundation
import CoreData
import RxSwift

protocol CoreDataRepositoryType {
    func checkFavouriteExist(id: String) -> Observable<Bool>
    func getAllFavourites() -> Observable<[FoodEntity]>
    func saveFavourite(food: Food) -> Observable<Void>
    func deleteFavourite(id: String) -> Observable<Void>
}

final class CoreDataRepositoryImpl: CoreDataRepositoryType {
    func checkFavouriteExist(id: String) -> Observable<Bool> {
        return CoreDataService.shared.checkFavouriteExist(id: id)
    }
    
    func saveFavourite(food: Food) -> Observable<Void> {
        return CoreDataService.shared.saveFavourite(food: food)
    }
    
    func deleteFavourite(id: String) -> Observable<Void> {
        return CoreDataService.shared.deleteFavourite(id: id)
    }
    
    func getAllFavourites() -> Observable<[FoodEntity]> {
        return CoreDataService.shared.getAllFavourites()
    }
    
}


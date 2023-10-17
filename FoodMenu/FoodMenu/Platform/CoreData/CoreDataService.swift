//
//  CoreDataService.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 17/10/2023.
//

import CoreData
import RxSwift
import Then

final class CoreDataService {
    let request = FoodEntity.fetchRequest()
    
    static let shared = CoreDataService()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodEntity")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Load Core Data failed: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func checkFavouriteExist(id: String) -> Observable<Bool> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            do {
                let favouriteEntity = try context.fetch(self.request)
                observer.onNext(favouriteEntity.contains(where: { $0.id == id }))
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataErrorType.checkExistFailed)
            }
            return Disposables.create()
        }
    }
    
    func getAllFavourites() -> Observable<[FoodEntity]> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            do {
                let foodEntity = try context.fetch(self.request)
                observer.onNext(foodEntity)
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataErrorType.getFailed)
            }
            return Disposables.create()
        }
    }
    
    func saveFavourite(food: Food) -> Observable<Void> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            do {
                let foodEntity = FoodEntity(context: context)
                foodEntity.then {
                    $0.id = food.id
                    $0.name = food.name
                    $0.desc = food.description
                    $0.image = food.image
                    $0.calories = "\(food.calories)"
                    $0.category = food.category
                }
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func deleteFavourite(id: String) -> Observable<Void> {
        return Observable.create { [self] observer in
            let fetchRequest: NSFetchRequest<FoodEntity> = FoodEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            do {
                let matchingFoodEntities = try self.persistentContainer.viewContext.fetch(fetchRequest)
                if let foodEntityToDelete = matchingFoodEntities.first {
                    self.persistentContainer.viewContext.delete(foodEntityToDelete)
                    try self.persistentContainer.viewContext.save()
                    observer.onNext(())
                    observer.onCompleted()
                } else {
                    observer.onError(CoreDataErrorType.deleteFailed)
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

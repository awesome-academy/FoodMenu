//
//  CoreDataErrorType.swift
//  FoodMenu
//
//  Created by Bach Nghiem on 17/10/2023.
//

import Foundation
enum CoreDataErrorType: Error {
    case getFailed
    case saveFailed
    case deleteFailed
    case checkExistFailed
}

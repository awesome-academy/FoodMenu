// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add To Favourite List Sucessfully
  internal static let addToFavouriteList = L10n.tr("Localizable", "addToFavouriteList", fallback: "Add To Favourite List Sucessfully")
  /// calories
  internal static let calories = L10n.tr("Localizable", "calories", fallback: "calories")
  /// categorycellid
  internal static let categoryCell = L10n.tr("Localizable", "categoryCell", fallback: "categorycellid")
  /// DetailFood
  internal static let detailFood = L10n.tr("Localizable", "DetailFood", fallback: "DetailFood")
  /// The data received from the server is invalid. Please try again
  internal static let errorDecoding = L10n.tr("Localizable", "errorDecoding", fallback: "The data received from the server is invalid. Please try again")
  /// list.bullet
  internal static let favoriteIcon = L10n.tr("Localizable", "favoriteIcon", fallback: "list.bullet")
  /// Favorite
  internal static let favoriteTabTitle = L10n.tr("Localizable", "favoriteTabTitle", fallback: "Favorite")
  /// Favourite
  internal static let favoriteTitle = L10n.tr("Localizable", "favoriteTitle", fallback: "Favourite")
  /// Favourite Food
  internal static let favourite = L10n.tr("Localizable", "favourite", fallback: "Favourite Food")
  /// heart
  internal static let favouriteIcon = L10n.tr("Localizable", "favouriteIcon", fallback: "heart")
  /// FoodCategory
  internal static let foodCategory = L10n.tr("Localizable", "FoodCategory", fallback: "FoodCategory")
  /// tableviewcellid
  internal static let foodCell = L10n.tr("Localizable", "foodCell", fallback: "tableviewcellid")
  /// Localizable.strings
  ///   FoodMenu
  /// 
  ///   Created by Bach Nghiem on 06/10/2023.
  internal static let homeIcon = L10n.tr("Localizable", "homeIcon", fallback: "house")
  /// Home
  internal static let homeTabTitle = L10n.tr("Localizable", "homeTabTitle", fallback: "Home")
  /// Food Menu
  internal static let homeTitle = L10n.tr("Localizable", "homeTitle", fallback: "Food Menu")
  /// takeoutbag.and.cup.and.straw
  internal static let imageOrder = L10n.tr("Localizable", "imageOrder", fallback: "takeoutbag.and.cup.and.straw")
  /// heart.fill
  internal static let inFavouriteIcon = L10n.tr("Localizable", "inFavouriteIcon", fallback: "heart.fill")
  /// The url is invalid, input a valid url
  internal static let invalidUrl = L10n.tr("Localizable", "invalidUrl", fallback: "The url is invalid, input a valid url")
  /// itemcategorycellid
  internal static let itemCategoryCell = L10n.tr("Localizable", "itemCategoryCell", fallback: "itemcategorycellid")
  /// collectionviewcellid
  internal static let itemFoodCell = L10n.tr("Localizable", "itemFoodCell", fallback: "collectionviewcellid")
  /// FoodMenu
  internal static let nameApp = L10n.tr("Localizable", "NameApp", fallback: "FoodMenu")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok", fallback: "OK")
  /// Order Food
  internal static let orderFood = L10n.tr("Localizable", "orderFood", fallback: "Order Food")
  /// Your order has been received 😋😋😋
  internal static let orderSuccess = L10n.tr("Localizable", "orderSuccess", fallback: "Your order has been received 😋😋😋")
  /// Popular
  internal static let popular = L10n.tr("Localizable", "popular", fallback: "Popular")
  /// Remove To Favourite List Sucessfully
  internal static let removeToFavouriteList = L10n.tr("Localizable", "removeToFavouriteList", fallback: "Remove To Favourite List Sucessfully")
  /// Invalid response from the server. Please try again.
  internal static let serverError = L10n.tr("Localizable", "serverError", fallback: "Invalid response from the server. Please try again.")
  /// Special
  internal static let special = L10n.tr("Localizable", "special", fallback: "Special")
  /// Thank you!
  internal static let thanks = L10n.tr("Localizable", "thanks", fallback: "Thank you!")
  /// Unable to complete your request. Please check your internet connection
  internal static let unableToComplete = L10n.tr("Localizable", "unableToComplete", fallback: "Unable to complete your request. Please check your internet connection")
  /// I have no idea what is wrong
  internal static let unknownError = L10n.tr("Localizable", "unknownError", fallback: "I have no idea what is wrong")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

//
//  SettingDataManager.swift
//  loopr-ios
//
//  Created by xiaoruby on 3/2/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import Foundation

class SettingDataManager {
    
    static let shared = SettingDataManager()
    
    private init() {
        
    }

    // MARK: Language
    func getSupportedLanguages() -> [Language] {
        let languageNames = Bundle.main.localizations
        let languages = languageNames.filter ({ (languageName) -> Bool in
            return languageName != "Base"
        }).map { (name) -> Language in
            return Language(name: name)
        }
        return languages
    }

    func setCurrentLanguage(_ language: Language) {
        let defaults = UserDefaults.standard
        defaults.set(language.name, forKey: UserDefaultsKeys.currentLanguage.rawValue)
    }
    
    func getCurrentLanguage() -> Language {
        let defaults = UserDefaults.standard
        if let languageName = defaults.string(forKey: UserDefaultsKeys.currentLanguage.rawValue) {
            return Language(name: languageName)
        }
        if let languageName = Bundle.main.preferredLocalizations.first {
            return Language(name: languageName)
        }
        return Language(name: "en")
    }
    
    // MARK: Currency
    func getSupportedCurrencies() -> [Currency] {
        let currencyNames = ["CNY", "USD", "HKD"]
        let currencies = currencyNames.filter ({ (currencyName) -> Bool in
            return currencyName != "Base"
        }).map { (name) -> Currency in
            return Currency(name: name)
        }
        return currencies
    }
    
    func setCurrentCurrency(_ currency: Currency) {
        let defaults = UserDefaults.standard
        defaults.set(currency.name, forKey: UserDefaultsKeys.currentCurrency.rawValue)
        PriceQuoteDataManager.shared.startGetPriceQuote()
    }
    
    func getCurrentCurrency() -> Currency {
        let defaults = UserDefaults.standard
        if let currencyName = defaults.string(forKey: UserDefaultsKeys.currentCurrency.rawValue) {
            return Currency(name: currencyName)
        }
        if let currencyName = Bundle.main.preferredLocalizations.first {
            return Currency(name: currencyName)
        }
        return Currency(name: "USD")
    }

    // MARK: Hide small assets
    func getHideSmallAssets() -> Bool {
        let defaults = UserDefaults.standard
        // If the value is absent or can't be converted to a BOOL, NO will be returned.
        let showSmallAssets = defaults.bool(forKey: UserDefaultsKeys.showSmallAssets.rawValue)
        return !showSmallAssets
    }
    
    func setHideSmallAssets(_ hide: Bool) {
        let showSmallAssets = !hide
        let defaults = UserDefaults.standard
        defaults.set(showSmallAssets, forKey: UserDefaultsKeys.showSmallAssets.rawValue)
    }
}

//
//  RALanguage.swift
//  RALocalization
//
//  Created by Rashed Al Lahaseh on 10/17/17.
//

import Foundation
import UIKit

let APPLE_LANGUAGE_KEY      = "AppleLanguages"
let FONT_TYPE               = "Lato-LightItalic"

public enum RALanguages: String {
    case english            = "en"
    case french             = "fr"
    case spanish            = "es"
    case german             = "de"
    case arabic             = "ar"
    case hebrew             = "he"
    case japanese           = "ja"
    case chineseSimplified  = "zh-Hans"
    case chineseTraditional = "zh-Hant"
}

open class RALanguage {
    // Get Current App language
    open class func currentLanguage(withLocale: Bool = true) -> String{
        let userDefault             = UserDefaults.standard
        let languageArray           = userDefault.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current                 = languageArray.firstObject as! String
        let index                   = current.index(current.startIndex, offsetBy: 2)
        let currentWithoutLocale    = String(current[..<index])
        
        return withLocale ? currentWithoutLocale : current
    }
    
    /// set @lang to be the first in App Languages List
    open class func setLanguage(language: RALanguages) {
        let userDefault = UserDefaults.standard
        userDefault.set([language.rawValue, currentLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userDefault.synchronize()
    }
    
    open class var isRTL: Bool {
        if RALanguage.currentLanguage() == RALanguages.arabic.rawValue {
            return true
        } else if RALanguage.currentLanguage() == RALanguages.hebrew.rawValue {
            return true
        } else {
            return false
        }
    }
}

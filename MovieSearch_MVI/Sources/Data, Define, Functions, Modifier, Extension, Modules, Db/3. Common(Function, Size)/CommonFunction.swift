//
//  CommonFunction.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Foundation
import UIKit

struct CommonFunction {
    static func defaultParams() -> [String: Any] {
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let osVersion = UIDevice.current.systemVersion
        let countryCode = Locale.current.regionCode ?? ""
        
        var params: [String: Any] = [:]
        params[DefineKey.appVersion] = appVersion
        params[DefineKey.device] = "iphone"
        params[DefineKey.osVersion] = osVersion
        params[DefineKey.countryCode] = countryCode
        
        return params
    }
    
    static func defaultHeader(acceptLanguage: String = "") -> [String:String] {
        var header: [String:String] = [:]
        header[DefineKey.referer] = "http://fantoo.co.kr"
        header[DefineKey.user_agent] = "fantoo-iphone"
        if acceptLanguage == "" {
            header[DefineKey.accept_language] = LanguageManager.shared.getLanguageCode()
        } else {
            header[DefineKey.accept_language] = acceptLanguage
        }
        return header
    }
    
}

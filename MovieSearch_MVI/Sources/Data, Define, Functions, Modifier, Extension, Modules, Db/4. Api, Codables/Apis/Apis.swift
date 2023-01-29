//
//  Apis.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Moya
import Foundation

enum Apis {
    case Config
}

extension Apis: Moya.TargetType {
    var baseURL: URL {
        switch self {
        case .Config:
            return URL(string: "http://api.fantoo.co.kr:3000")!
        }
    }
    
    var path: String {
        switch self {
        case .Config:
            return "api/native/config/ios_real"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Config:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .Config:
            let params = defultParams
            log(params: params)
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var header = CommonFunction.defaultHeader()
        
        switch self {
            
        default:
            //header["Content-Type"] = "binary/octet-stream"
            //            header["Content-Type"] = "application/x-www-form-urlencoded"
            header["Content-Type"] = "application/json"
        }
        
        return header
    }
    
    
    var defultParams: [String : Any] {
        return CommonFunction.defaultParams()
    }
    
    func log(params: [String: Any]) {
        print("\n--- API : \(baseURL)/\(path) -----------------------------------------------------------\n\(params)\n------------------------------------------------------------------------------------------------------------------------------\n")
    }
}

extension Apis {
    var cacheTime:NSInteger {
        var time = 0
        switch self {
        default: time = 15
        }
        
        return time
    }
}



//MARK: - Log On/Off
extension Apis {
    func isAlLogOn() -> Bool {
        return false
    }
    
    func isLogOn() -> [Bool] {
        switch self {
        case .Config:
            return [true, true]
        }
    }
    
    func isApiLogOn() -> Bool {
        if self.isAlLogOn(), self.isLogOn()[0] {
            return true
        }
        
        return false
    }
    
    func isResponseLog() -> Bool {
        if self.isAlLogOn(), self.isLogOn()[1] {
            return true
        }
        
        return false
    }
}


//MARK: - Check Token or not
extension Apis {
    func isCheckToken() -> Bool {
        switch self {
        case .Config:
            return true
        }
    }
}


//MARK: - Caching Time : Seconds
extension Apis {
    func dataCachingTime() -> Int {
        switch self {
        case .Config:
            return DataCachingTime.None.rawValue
        }
    }
}

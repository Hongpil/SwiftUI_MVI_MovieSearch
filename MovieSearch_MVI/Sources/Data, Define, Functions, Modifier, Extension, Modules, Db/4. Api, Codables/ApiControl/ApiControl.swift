//
//  ApiControl.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Foundation
import Moya
import Combine

struct ApiControl {
    static var canclelables = Set<AnyCancellable>()
    
    static func config() -> AnyPublisher<ConfigData, ErrorModel> {
        Future<ConfigData, ErrorModel> { promise in
            
            let apis: Apis = .Config
            //call
            let provider = MoyaProvider<Apis>()
            provider.requestPublisher(apis)
                .sink(receiveCompletion: { completion in
                    guard case let .failure(error) = completion else { return }
                    print(error)
                    promise(.failure(ErrorModel(code: "error")))
                }, receiveValue: { response in
                    jsonLog(data: response.data, systemCode: response.statusCode)
                    let result = try? JSONDecoder().decode(ConfigData.self, from: response.data)
                    if result != nil {
                        promise(.success(result!))
                    }
                    else {
                        promise(.failure(ErrorModel(code: "error")))
                    }
                })
                .store(in: &canclelables)
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: - Log
    static func jsonLog(data:Data, systemCode:Int, functionName:String = #function, isLogOn:Bool = false) {
        if isLogOn {
            print("\n--- Response Code : \(systemCode) (\(functionName)) ------------------------------------------------------------------------------\n\(String(data: data, encoding: .utf8) ?? "None")\n------------------------------------------------------------------------------\n")
        }
    }
}

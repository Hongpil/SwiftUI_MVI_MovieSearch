//
//  ApiControl+DetailPage.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Foundation
import Moya
import Combine

extension ApiControl {
    
    /**
     * Club DetailPage
     */
    static func getClubDetail(clubId: String, categoryCode: String, postId: Int, integUid: String, access_token: String) -> AnyPublisher<ClubDetailModel, ErrorModel> {
        Future<ClubDetailModel, ErrorModel> { promise in
            
            let apis: ApisDetailPage = .ClubDetail(clubId: clubId, categoryCode: categoryCode, postId: postId, integUid: integUid, access_token: access_token)
            //call
            let provider = MoyaProvider<ApisDetailPage>()
            provider.requestPublisher(apis)
                .sink(receiveCompletion: { completion in
                    guard case let .failure(error) = completion else { return }
                    print(error)
                    promise(.failure(ErrorModel(code: "error")))
                }, receiveValue: { response in
                    
                    jsonLog(data: response.data, systemCode: response.statusCode, isLogOn: apis.isResponseLog())

                    //error check start --------------------------------------------------------------------------------
                    if response.statusCode != 200 {
                        let result = try? JSONDecoder().decode(ErrorModel.self, from: response.data)
                        if result != nil {
                            promise(.failure(result!))
                        }
                        else {
                            promise(.failure(ErrorModel(code: "error")))
                        }

                        return
                    }
                    //error check end --------------------------------------------------------------------------------

                    let result = try? JSONDecoder().decode(ClubDetailModel.self, from: response.data)
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
    
    /**
     * Club DetailPage Reply
     */
    static func getClubDetailReply(clubId: String, categoryCode: String, postId: Int, integUid: String, access_token: String, nextId: String, size: String) -> AnyPublisher<ClubDetailReplyModel, ErrorModel> {
        Future<ClubDetailReplyModel, ErrorModel> { promise in
            
            let apis: ApisDetailPage = .ClubDetailReply(clubId: clubId, categoryCode: categoryCode, postId: postId, integUid: integUid, access_token: access_token, nextId: nextId, size: size)
            //call
            let provider = MoyaProvider<ApisDetailPage>()
            provider.requestPublisher(apis)
                .sink(receiveCompletion: { completion in
                    guard case let .failure(error) = completion else { return }
                    print(error)
                    promise(.failure(ErrorModel(code: "error")))
                }, receiveValue: { response in
                    
                    jsonLog(data: response.data, systemCode: response.statusCode, isLogOn: apis.isResponseLog())

                    //error check start --------------------------------------------------------------------------------
                    if response.statusCode != 200 {
                        let result = try? JSONDecoder().decode(ErrorModel.self, from: response.data)
                        if result != nil {
                            promise(.failure(result!))
                        }
                        else {
                            promise(.failure(ErrorModel(code: "error")))
                        }

                        return
                    }
                    //error check end --------------------------------------------------------------------------------

                    let result = try? JSONDecoder().decode(ClubDetailReplyModel.self, from: response.data)
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
    
    
}

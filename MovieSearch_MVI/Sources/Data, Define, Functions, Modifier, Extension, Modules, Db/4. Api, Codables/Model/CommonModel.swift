//
//  CommonModel.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Foundation

struct ErrorModel: Codable, Error {
    var code : String = ""
    
//    var msg : String? = ""
//    var code: String = "" {
//        didSet {
//
//        }
//    }

    var message: String {
        //return ErrorHandler.getErrorMessage(code: code)
        return ""
    }
}

/**
 * 클럽 공통
 */
struct ClubCommonModel_AttachList: Codable, Hashable {
    let attachType, attachId: Int?
    let attach: String?
}
struct ClubCommonModel_Like: Codable, Hashable {
    let likeYn: Bool?
    let likeCount, dislikeCount: Int?
}
struct ClubCommonModel_OpenGraphDtoList: Codable, Hashable {
    let description, domain, image, title, url: String?
}

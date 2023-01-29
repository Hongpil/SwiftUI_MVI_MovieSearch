//
//  ClubDetailPageModel.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Foundation

/**
 * 클럽 2뎁스(말머리) 게시물 상세
 */
struct ClubDetailModel: Codable {
    let attachType, blockType, boardType, deleteType, memberId, memberLevel, postId, replyCount, status: Int?
    let categoryCode, categoryName1, categoryName2, clubId, clubName, content, createDate, firstImage, integUid, langCode, link, nickname, profileImg, subject, url: String?
    let attachList: [ClubCommonModel_AttachList]?
    let hashtagList: [String]?
    let like: ClubCommonModel_Like?
}

/**
 * 클럽 2뎁스(말머리) 게시물 상세 - 댓글 리스트
 */
struct ClubDetailReplyModel: Codable {
    var listSize: Int?
    var nextId: String?
    var replyList: [ClubDetailReplyModel_ReplyList]?
}

struct ClubDetailReplyModel_ReplyList: Codable, Hashable {
    let blockType, deleteType, depth, level, memberId, parentReplyId, postId, replyCount, replyId, status: Int?
    let categoryCode, categoryName1, categoryName2, clubId, clubName, content, createDate, integUid, langCode, nickname, profileImg, subject, updateDate, url: String?
    let attachList: [ClubCommonModel_AttachList]?
    let like: ClubCommonModel_Like?
    let openGraphDtoList: [ClubCommonModel_OpenGraphDtoList]?
}

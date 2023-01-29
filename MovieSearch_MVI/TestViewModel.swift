//
//  TestViewModel.swift
//  MovieSearch_MVI
//
//  Created by kimhongpil on 2023/01/29.
//

import Foundation
import Combine

class TestViewModel: ObservableObject {
    var canclelables = Set<AnyCancellable>()
    private var replyNextId: String = "0"
    
    // 페이지 전환시 받는 데이터
    @Published var postId: Int = 0
    @Published var clubId: String = ""
    @Published var categoryCode: String = ""
    // 클럽 2뎁스(말머리) 게시물 상세
    @Published var clubDetailModel: ClubDetailModel?
    // 클럽 2뎁스(말머리) 게시물 상세 - 댓글 리스트
    @Published var replyList = [ClubDetailReplyModel_ReplyList]()
    
    /**
     * 클럽상세
     */
    func getClubDetail(clubId: String, categoryCode: String, postId: Int, integUid: String, access_token: String) {
        ApiControl.getClubDetail(
            clubId: clubId,
            categoryCode: categoryCode,
            postId: postId,
            integUid: integUid,
            access_token: access_token
        )
        .sink { error in
            //CommonFunction.offPageLoading()
        } receiveValue: { value in
            //CommonFunction.offPageLoading()
            
            self.clubDetailModel = value
            print("clubDetailModel : \(self.clubDetailModel)")
            
//            debugPrint("clubId : \(self.clubId)")
//            debugPrint("categoryCode : \(self.categoryCode)")
//            debugPrint("postId : \(self.postId)")
            
            // for test
//            self.clubDetailModel?.hashtagList?.append("팬투1")
//            self.clubDetailModel?.hashtagList?.append("팬투2")
//            self.clubDetailModel?.hashtagList?.append("팬투3")
//            self.clubDetailModel?.hashtagList?.append("한류뱅크1")
//            self.clubDetailModel?.hashtagList?.append("한류뱅크2")
//            self.clubDetailModel?.hashtagList?.append("한류뱅크3")
            
            
            // 상세글 내용 다 받고, 댓글 내용 받기
            self.getClubDetailReply(
                clubId: clubId,
                categoryCode: categoryCode,
                postId: postId,
                integUid: integUid,
                access_token: access_token,
                size: String(20)
            )
        }
        .store(in: &canclelables)
    }
    
    /**
     * 클럽상세 댓글 목록
     */
    func getClubDetailReply(clubId: String, categoryCode: String, postId: Int, integUid: String, access_token: String, size: String) {
        ApiControl.getClubDetailReply(clubId: clubId, categoryCode: categoryCode, postId: postId, integUid: integUid, access_token: access_token, nextId: self.replyNextId, size: size)
        .sink { error in
            //CommonFunction.offPageLoading()
        } receiveValue: { value in
            //CommonFunction.offPageLoading()
            
            print("value : \(value)")
            // 첫 페이지만 해당 (페이징 X)
            if self.replyNextId == "0" {
                if let NOnextId = value.nextId {
                    self.replyNextId = NOnextId
                }
                if let NOreplyList = value.replyList {
                    self.replyList = NOreplyList
                }
            }
            // 페이징으로 받아오는 데이터
            else {
                if let NOnextId = value.nextId {
                    self.replyNextId = NOnextId
                    
                    if let NOreplyList = value.replyList {
                        self.replyList.append(contentsOf: NOreplyList)
                    }
                }
                // value.nextId is nil
                else {
                    self.replyNextId = "-1"
                }
            }
        }
        .store(in: &canclelables)
    }
    
    func setPassedInfo(postId: Int, clubId: String, categoryCode: String) {
        self.postId = postId
        self.clubId = clubId
        self.categoryCode = categoryCode
    }
}

//
//  Content.swift
//  ArticleContentMaker
//
//  Created by 한현민 on 3/17/24.
//

import Foundation

struct Content {
    var title: String?
    var date: String? // TODO: 나중에 DateFormatter 가지고 Date 타입으로 바꾸기 -> DatePicker 활용하자
    var trackList: String? // TODO: [String]?으로 바꾸기
    var passage: String?

    // TODO: [String]?으로 바꾸기
    // # 기호는 제외하고 받기.
    var hashtags: String?

//    var trackListString: String {
//        guard let trackList else {
//            return ""
//        }
//        var currentIndex = 1
//        return trackList
//            .map { track in
//                let labeled = "\(currentIndex). \(track)"
//                currentIndex += 1
//                return labeled
//            }
//            .joined(separator: "\n")
//    }
//
//    var hashtagsString: String {
//        guard let hashtags else {
//            return ""
//        }
//
//        return hashtags
//            .map { tag in
//                "#\(tag)"
//            }
//            .joined(separator: " ")
//    }

    var fullContext: String {
        "[\(title ?? "")] (\(date ?? "")) \n\n \(trackList ?? "") \n\n \(passage ?? "") \n\n \(hashtags ?? "")"
    }

//    var fullContext: String {
//        "[\(title ?? "")] (\(date ?? "")) \n\n \(trackListString) \n\n \(passage ?? "") \n\n \(hashtagsString)"
//    }
}

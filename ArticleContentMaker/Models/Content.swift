//
//  Content.swift
//  ArticleContentMaker
//
//  Created by 한현민 on 3/17/24.
//

import Foundation

/**
 titleTextField
 dateTextField (NSDatePicker 이거 맞나? 암튼 그걸로 변경 예정)
 trackListTextView
 passageTextView
 hashTagsTextView

 resultTextView
 */

struct Content {
    var title: String?
    var date: Date? // TODO: 나중에 DateFormatter 가지고 Date 타입으로 바꾸기 -> DatePicker 활용하자
    var trackList: [String]? // TODO: [String]?으로 바꾸기
    var passage: String?

    // TODO: [String]?으로 바꾸기
    // # 기호는 제외하고 받기.
    var hashtags: String?

    var dateString: String {
        guard let date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .init(identifier: "ko_KR")
        formatter.dateFormat = "yyMMdd"

        return formatter.string(from: date)
    }

    var trackListString: String {
        guard let trackList else {
            return ""
        }

        var currentIndex = 1
        return trackList
            .map { track in
                let labeled = "\(currentIndex). \(track)"
                currentIndex += 1
                return labeled
            }
            .joined(separator: "\n")
    }

    var hashtagsString: String {
        guard let hashtags else {
            return ""
        }

        return hashtags
            .map { tag in
                "#\(tag)"
            }
            .joined(separator: " ")
    }

    var fullContext: String {
        "[\(title ?? "")] (\(dateString))\n\n\(trackListString)\n\n\(passage ?? "")\n\n\(hashtags ?? "")"
    }

//    var fullContext: String {
//        "[\(title ?? "")] (\(date ?? "")) \n\n \(trackListString) \n\n \(passage ?? "") \n\n \(hashtagsString)"
//    }
}

class ContentStore {
    var content = Content()
    
    func fetchData() {
        content.title = ""
        content.date = Date()
        content.trackList = [""]
        content.passage = ""
        content.hashtags = ""
    }
    
    func update(_ content: Content) {
        self.content = content
    }
}

//
//  NSLabel.swift
//  ArticleContentMaker
//
//  Created by 한현민 on 3/17/24.
//

import AppKit

// 읽기 전용 텍스트필드
class NSLabel: NSTextField {
    var text: String = "" {
        didSet {
            self.stringValue = text
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setProperties()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Error")
    }

    private func setProperties() {
        self.isEditable = false
        self.isBordered = false
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  MainView.swift
//  ArticleContentMaker
//
//  Created by 한현민 on 4/7/24.
//

// 4/7 TODO: 일단 커밋하고 집가서 NSTableView 붙여보고 스유 튜토리얼 한번 보자

import AppKit

class MainView: NSView {
    var content: Content? {
        didSet {
            guard let content = content else {
                return
            }
            
            titleTextField.stringValue = content.title ?? ""
            datePicker.dateValue = content.date ?? Date()
            trackListTextView.string = content.trackList?[0] ?? ""
            passageTextView.string = content.passage ?? ""
            hashTagsTextView.string = content.hashtags ?? ""
        }
    }
    
    // views
    // editView 제목
    lazy var titleLabel: NSLabel = {
        let label = NSLabel()
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleTextField: NSTextField = {
        let label = NSTextField()
        label.placeholderString = "제목 입력..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.alignment = .left
        sv.spacing = 10
        sv.addArrangedSubview(self.titleLabel)
        sv.addArrangedSubview(self.titleTextField)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // editView 날짜
    lazy var dateLabel: NSLabel = {
        let label = NSLabel()
        label.text = "날짜"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // TODO: DatePicker로 바꾸기
    lazy var datePicker: NSDatePicker = {
        let picker = NSDatePicker()
        picker.datePickerStyle = .textFieldAndStepper   // 텍스트필드에 증감 버튼 추가
        picker.datePickerElements = .yearMonthDay   // 표기 항목을 연/월/일로 변경
        picker.locale = .init(identifier: "ko_KR")  // 날짜 표기 방식을 연/월/일로 변경
        picker.dateValue = .init()  // 오늘 날짜로 기본값 변경
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var dateStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.alignment = .left
        sv.spacing = 4
        sv.addArrangedSubview(self.dateLabel)
        sv.addArrangedSubview(self.datePicker)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // editView 트랙 목록
    lazy var trackListLabel: NSLabel = {
        let label = NSLabel()
        label.text = "트랙 목록"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trackListTextView: NSTextView = {
        let label = NSTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trackListStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.alignment = .left
        sv.spacing = 10
        sv.addArrangedSubview(self.trackListLabel)
        sv.addArrangedSubview(self.trackListTextView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // editView 본문
    lazy var passageLabel: NSLabel = {
        let label = NSLabel()
        label.text = "본문"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passageTextView: NSTextView = {
        let label = NSTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passageStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.alignment = .left
        sv.spacing = 10
        sv.addArrangedSubview(self.passageLabel)
        sv.addArrangedSubview(self.passageTextView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // editView 해시태그 목록
    lazy var hashTagsLabel: NSLabel = {
        let label = NSLabel()
        label.text = "해시태그 목록"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hashTagsTextView: NSTextView = {
        let label = NSTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hashTagsStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.alignment = .left
        sv.spacing = 10
        sv.addArrangedSubview(self.hashTagsLabel)
        sv.addArrangedSubview(self.hashTagsTextView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var editStackView: NSStackView = {
        let sv = NSStackView()
        sv.spacing = 20
        sv.orientation = .vertical
        sv.alignment = .left
        sv.addArrangedSubview(self.titleStackView)
        sv.addArrangedSubview(self.dateStackView)
        sv.addArrangedSubview(self.trackListStackView)
        sv.addArrangedSubview(self.passageStackView)
        sv.addArrangedSubview(self.hashTagsStackView)
        
        sv.wantsLayer = true
        sv.edgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // resultView
    // 설명 부분
    lazy var resultIntroduceTitleLabel: NSLabel = {
        let label = NSLabel()
        label.text = "변환 결과"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: View와 VC 분리할 때 버튼을 어떻게 구성할 것인가?
    // 1) title, image와 같은 레이블 속성은 View에서 설정하고
    // 2) target, action과 같은 이벤트 처리 관련 속성은 VC에서 설정한다.
    lazy var convertButton: NSButton = {
        let button = NSButton()
        button.title = "변환"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resultShareButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: nil)!
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resultTitleStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .horizontal
        sv.spacing = 10
        sv.alignment = .top
        sv.distribution = .fillProportionally
        sv.addArrangedSubview(self.resultIntroduceTitleLabel)
        sv.addArrangedSubview(self.convertButton)
        sv.addArrangedSubview(self.resultShareButton)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var resultIntroduceDescriptionLabel: NSLabel = {
        let label = NSLabel()
        label.text = "왼쪽 입력 화면에 입력된 텍스트를 변환합니다."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var resultIntroduceStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.spacing = 10
        sv.addArrangedSubview(self.resultTitleStackView)
        sv.addArrangedSubview(self.resultIntroduceDescriptionLabel)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // 변환 결과 텍스트
    lazy var resultTextView: NSTextView = {
        let label = NSTextView()
        label.string = ""
        label.font = .systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var resultStackView: NSStackView = {
        let sv = NSStackView()
        sv.spacing = 20
        sv.orientation = .vertical
        sv.addArrangedSubview(self.resultIntroduceStackView)
        sv.addArrangedSubview(self.resultTextView)
        
        sv.wantsLayer = true
        sv.edgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var viewStack: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .horizontal
        sv.spacing = 20
        sv.alignment = .top
        sv.addArrangedSubview(self.editStackView)
        sv.addArrangedSubview(self.resultStackView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.wantsLayer = true
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func setupUI() {
        self.addSubview(viewStack)

        NSLayoutConstraint.activate([
            viewStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            viewStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            viewStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            viewStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            editStackView.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 10),
            editStackView.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -10),
            resultStackView.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 10),
            resultStackView.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            trackListTextView.heightAnchor.constraint(equalToConstant: 120),
            passageTextView.heightAnchor.constraint(equalToConstant: 240),
            hashTagsTextView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            titleTextField.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            datePicker.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            datePicker.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            trackListTextView.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            trackListTextView.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            passageTextView.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            passageTextView.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            hashTagsTextView.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            hashTagsTextView.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
        ])
    }
}

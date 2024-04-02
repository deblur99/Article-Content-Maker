//
//  ViewController.swift
//  ArticleContentMaker
//
//  Created by 한현민 on 3/17/24.
//

/*
 뭘 구현할거냐면....
 본문 자동으로 만들어주는 앱!
 
 1. 데이터 모델 구성하기 (완)
 
 2. 화면 배치
 
 3. 로직 구현
 
 4. 클립보드로 공유 기능 (우측 상단에 놓든가 하는...)
 */

import AppKit

class ViewController: NSViewController {
    var content = Content()
    
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
    lazy var dateTextField: NSTextField = {
        let label = NSTextField()
        label.placeholderString = "날짜 입력..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateStackView: NSStackView = {
        let sv = NSStackView()
        sv.orientation = .vertical
        sv.alignment = .left
        sv.spacing = 10
        sv.addArrangedSubview(self.dateLabel)
        sv.addArrangedSubview(self.dateTextField)
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
    
    // TODO: 버튼 동작하게 만들기... 왜 안되냐....
    lazy var convertButton: NSButton = {
        let button = NSButton(title: "변환", target: self, action: #selector(shareButtonClicked))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resultShareButton: NSButton = {
        let button = NSButton(image: NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: nil)!, target: self, action: #selector(convertButtonClicked))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    private func setupUI() {
        view.addSubview(viewStack)

        NSLayoutConstraint.activate([
            viewStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            viewStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            viewStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            editStackView.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 10),
            editStackView.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -10),
            resultStackView.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 10),
            resultStackView.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            trackListTextView.heightAnchor.constraint(equalToConstant: 120),
            passageTextView.heightAnchor.constraint(equalToConstant: 240),
            hashTagsTextView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            titleTextField.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            dateTextField.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            dateTextField.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            trackListTextView.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            trackListTextView.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            passageTextView.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            passageTextView.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
            
            hashTagsTextView.leadingAnchor.constraint(equalTo: editStackView.leadingAnchor, constant: 0),
            hashTagsTextView.trailingAnchor.constraint(equalTo: editStackView.trailingAnchor, constant: 0),
        ])
    }
    
    @objc func convertButtonClicked(_ sender: Any) {
        print(#function)
        
//        content.title = titleTextField.stringValue
//        content.date = dateTextField.stringValue
//        content.trackList = trackListTextView.string
//        content.passage = passageTextView.string
//        content.hashtags = hashTagsTextView.string
//        
//        resultTextView.string = content.fullContext
    }
    
    @objc func shareButtonClicked(_ sender: Any) {
        print(#function)
        // 공유 팝업 표시
//        let shareMenu = NSMenu(title: "공유")
//        let copyItem = NSMenuItem(title: "클립보드에 복사", action: #selector(copyToClipboard(_:)), keyEquivalent: "")
//        shareMenu.addItem(copyItem)
//        NSMenu.popUpContextMenu(shareMenu, with: NSApp.currentEvent!, for: view)
    }
    
//    @objc func copyToClipboard(_ sender: Any) {
//        // 클립보드에 데이터 복사
//        let dataToCopy = "본문 전체를 복사합니다."
//        NSPasteboard.general.clearContents()
//        NSPasteboard.general.setString(dataToCopy, forType: .string)
//        // 사용자에게 알림
//        NSAlert.showAlert(message: "본문이 클립보드에 복사되었습니다.", in: view.window)
//    }
}

//extension NSAlert {
//    static func showAlert(message: String, in window: NSWindow?) {
//        let alert = NSAlert()
//        alert.messageText = message
//        alert.addButton(withTitle: "OK")
//        alert.beginSheetModal(for: window!, completionHandler: nil)
//    }
//}

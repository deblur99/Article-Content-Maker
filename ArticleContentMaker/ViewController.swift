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

/**
 아직 남은게....
 
 1, NSTextView에서 공간 넘으면 스크롤되게 만들기 (진행중)
 2. 날짜 고르는 부분을 DatePicker로 만들기 (완료)
 3. 공유 기능 구현하기 (완료)
 
 
 
 */

import AppKit

class ViewController: NSViewController {
    var contentStore = ContentStore()
    
    // MARK: VC 생명주기 함수들
    /**
        - init()
        - loadView()
        - viewWillLoad()
        - viewDidLoad()
        - viewWillAppear()
        - viewDidAppear()
        - viewWillDisappear()
        - viewDidDisappear()
        - deinit()
     */
    
    override func loadView() {
        super.loadView()
        
        // 뷰와 관련된 부분 설정
        let mainView = MainView()
        mainView.convertButton.target = self
        mainView.convertButton.action = #selector(convertButtonClicked)
        
        mainView.resultShareButton.target = self
        mainView.resultShareButton.action = #selector(shareButtonClicked)
        view = mainView // VC의 뷰를 별도로 분리한 뷰로 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 관련된 부분 설정
        contentStore.fetchData()
        
        if let view = view as? MainView {
            view.content = contentStore.content
        }
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @objc func convertButtonClicked(_ sender: Any) {
        guard let view = view as? MainView else {
            return
        }
        
        var content = Content()

        content.title = view.titleTextField.stringValue
        content.date = view.datePicker.dateValue
        content.trackList = [view.trackListTextView.string]
        content.passage = view.passageTextView.string
        content.hashtags = view.hashTagsTextView.string
        view.resultTextView.string = content.fullContext
        
        contentStore.update(content)
    }
    
    @objc func shareButtonClicked(_ sender: Any) {
        // 공유 팝업 표시
        let shareMenu = NSMenu(title: "공유")
        let copyItem = NSMenuItem(title: "클립보드에 복사", action: #selector(copyToClipboard(_:)), keyEquivalent: "")
        shareMenu.addItem(copyItem)
        NSMenu.popUpContextMenu(shareMenu, with: NSApp.currentEvent!, for: view)
    }
    
    // 뷰와 관련된 부분이므로 ContentStore에 두는 대신 VC에 둔다.
    @objc func copyToClipboard(_ sender: Any) {
        // 클립보드에 데이터 복사
        let dataToCopy = contentStore.content.fullContext
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(dataToCopy, forType: .string)
        // 사용자에게 알림
        NSAlert.showAlert(message: "본문이 클립보드에 복사되었습니다.", in: view.window)
    }
}

extension NSAlert {
    static func showAlert(message: String, in window: NSWindow?) {
        let alert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "OK")
        alert.beginSheetModal(for: window!, completionHandler: nil)
    }
}

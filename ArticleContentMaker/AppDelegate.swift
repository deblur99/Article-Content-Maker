//
//  AppDelegate.swift
//  ArticleContentMaker
//
//  Created by 한현민 on 3/17/24.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    // MARK: NSWindow 객체를 새로 만들어서 뷰와 연결할 때는 반드시 뷰에 대한 VC의 강한 참조가 있어야 한다! (매우 중요)
    var viewController: ViewController! // 강한 참조 선언
    
    static let shared = AppDelegate()
    
    // 앱이 실행되었을 때 호출 (UIKit의 viewDidLoad와 유사)
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        showMainWindow()
    }
    
    func showMainWindow() {
        // 창의 시작 위치와 크기를 정하고, 어떤 모양으로 띄울지, 로딩될 때까지 화면을 보여줄건지 여부 결정 (defer)
        window = NSWindow(contentRect: .init(x: 0, y: 0, width: 400, height: 400), styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
        
        window.title = "Article Content Maker"
        window.setContentSize(.init(width: 600, height: 800))
        window.center() // 창을 가운데로 옮김

        // 코드로 구현한 ViewController를 창에 띄우려면, 여기서 VC의 인스턴스를 만들어서 window에 넣어줘야 한다.
        // let vc = ViewController()    // 약한 참조 -> error
        viewController = ViewController()
        window.contentView = viewController.view

        window.makeKeyAndOrderFront(nil) // 현재 화면을 화면 목록의 최상단으로 보여준다 (root view controller와 유사)
        window.delegate = self
    }
    
    // 앱이 실행되었을 때 호출되어, 팝업창으로 앱 종료 여부를 묻는다.
    // 버튼 추가할 때 addTarget을 사용할 필요가 없다.
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        let alert = NSAlert()
        alert.messageText = "앱을 종료하시겠습니까?" // 제목
        alert.informativeText = "모든 진행 상황이 사라집니다." // 설명
        alert.addButton(withTitle: "종료")
        alert.addButton(withTitle: "취소")
        
        let response = alert.runModal()
        // 종료 버튼이 눌렸을 때
        if response == .alertFirstButtonReturn {
            return .terminateNow
        } else {
            // 취소 버튼이 눌렸을 때
            return .terminateCancel
        }
    }
}

extension AppDelegate: NSWindowDelegate {
    // 창 닫혔을 때 실행되는 Delegate 메서드
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self) // 종료 트리거 발생시켜 종료 Delegate 호출
        return false // 창 닫기 버튼 눌렀을 때 창 닫기 방지
    }
}

//
//  ConfigCell.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/12/25.
//

import Foundation

protocol ReusableViewProtocol {
    func config()
    func config(row: Chat)
    func config(row: ChatRoom)
    func setupCell()
    
    // Cell에서 Type Prop으로 사용하기 위해선 프로토콜도 Type Prop으로 지정해야함.
    // 프로퍼티는 항상 var로!
    static var identifier: String { get }
}

extension ReusableViewProtocol {
    // MARK: 프로토콜의 메서드를 오버로딩 하면 어떨까? 싶은 마음에 이렇게 작성해봤는데 적절한 코드인지 궁금합니다!
    func config() { }
    func config(row: Chat) { }
    func config(row: ChatRoom) { }
}

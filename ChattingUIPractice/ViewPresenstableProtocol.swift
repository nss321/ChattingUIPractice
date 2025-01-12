//
//  ConfigUI.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/12/25.
//

import Foundation

protocol ViewPresenstableProtocol {
    func configTableView()
    func configLabel()
    func configTextField()
    func configSearchBar()
    func configNavigationBar()
}

extension ViewPresenstableProtocol {
    func configTableView() { }
    func configLabel() { }
    func configTextField() { }
    func configSearchBar() { }    
    func configNavigationBar() { }
}


// @objc를 붙이는 방법
// class는 Objective-C 를 상속받거나 @objc가 붙은 클래스에서만 사용할 수 있음.
//@objc protocol ConfigUI {
//    @objc optional func configTableView()
//    @objc optional func configLabel()
//    @objc optional func configTextField()
//    @objc optional func configSearchBar()
//    @objc optional func configNavigationBar()
//}

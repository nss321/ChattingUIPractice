//
//  DateFormatterManager.swift
//  ChattingUIPractice
//
//  Created by BAE on 1/11/25.
//

import Foundation

class DateFormatManager {
    
    static let shared = DateFormatManager()
    
    private init() { }
    
    /// 클로저를 이용한 프로퍼티의 초기화(저장 프로퍼티)
    /// 이 방식을 사용하면 클로저를 이용해 인스턴스 프로퍼티를 초기화 할 수 있다.
    /// 연산 프로퍼티와 유사하게 보일 수 있지만, 연산 프로퍼티는 호출시 '연산 그 자체'를 실행하기 때문에 값이 바뀔 수 있고, 
    /// 매번 연산을 시행한다.
    /// 반면 클로저를 이용한 초기화 방식은 최초 호출시에만 클로저를 이용해 프로퍼티를 초기화 하고 이후에는 같은 결과를 반환한다.

    private let converChatDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }()
    
    private let convertToDisplayDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter
    }()
    
    func convertChatdateToDisplaydate(date: String) -> String {
        guard let rawDate = converChatDate.date(from: date) else {
            print("날짜 변환 실패")
            return "00.00.00"
        }
        
        return convertToDisplayDate.string(from: rawDate)
    }
}

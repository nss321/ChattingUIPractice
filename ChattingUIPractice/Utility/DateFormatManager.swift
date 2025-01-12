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
    
    private let convertToTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "hh:mm aa"
        return dateFormatter
    }()
    
    private let convertToSeparatorDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 d일 EEEE"
        return dateFormatter
    }()
    
    func convertChatdateToDisplaydate(date: String) -> String {
        guard let rawDate = converChatDate.date(from: date) else {
            print(#function, "날짜 변환 실패")
            return "00.00.00"
        }
        return convertToDisplayDate.string(from: rawDate)
    }
    
    func convertChatdateToTime(date: String) -> String {
        guard let rawDate = converChatDate.date(from: date) else {
            print(#function, "시간 변환 실패")
            return "00:00 오전"
        }
        return convertToTime.string(from: rawDate)
    }
    
    func converToChatToSeparatorDate(date: String) -> String {
        guard let rawDate = converChatDate.date(from: date) else {
            print(#function, "구분선 날짜 변환 실패")
            return "0000년 0월 0알 0요일"
        }
        return convertToSeparatorDate.string(from: rawDate)
    }
    
    func isNewDay(_ last: String, _ current: String) -> Bool {
        guard let last = converChatDate.date(from: last) else {
            print(#function, "이전 날짜 변환 실패")
            return false
        }
        guard let current = converChatDate.date(from: current) else {
            print(#function, "현재 날짜 변환 실패")
            return false
        }
        
        let lastDate = Calendar.current.dateComponents([.year,.month, .day], from: last)
        let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: current)

        if lastDate.day! != currentDate.day! {
            return true
        } else {
            return false
        }
        
    }
}

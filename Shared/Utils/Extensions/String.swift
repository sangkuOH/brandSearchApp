//
//  String.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/16.
//

import Foundation

extension String {
    func toDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "ko")
        
        guard let tempDate = dateFormatter.date(from: self) else {
            print("Date 생성 실패")
            return ""
        }
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
        return dateFormatter.string(from: tempDate)
    }
}

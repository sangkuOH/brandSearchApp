//
//  GetPlistInfo.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import Foundation

func getPlistInfo(key: String) -> String {
    guard let value = Bundle.main.infoDictionary?[key] as? String else {
        return ""
    }
    return value
}

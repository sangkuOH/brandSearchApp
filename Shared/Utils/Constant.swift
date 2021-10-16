//
//  Constant.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import Foundation

class Constant {
    static var targetName = getPlistInfo(key: "TargetName")
    static var clientId = getPlistInfo(key: "CFBundleIdentifier")
    static var kakakAppKey = getPlistInfo(key: "KakaoAppKey")
    static var baseURL = getPlistInfo(key: "BaseURL")
}

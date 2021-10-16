//
//  Config.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/16.
//
import Foundation

enum AppConfiguration: String {
    case Local = "local"
    case Development = "development"
    case Staging = "staging"
    case Production = "production"
    
    var baseURL: String {
        switch self {
        case .Local: return Constant.baseURL
        case .Development: return Constant.baseURL
        case .Staging: return Constant.baseURL
        case .Production: return Constant.baseURL
        }
    }
}

var appConfig: AppConfiguration = {
    if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
        if configuration.contains("Debug") {
            return AppConfiguration.Local
        } else if configuration.contains("Release") {
            return AppConfiguration.Production
        }
    }
    
    return AppConfiguration.Production
}()

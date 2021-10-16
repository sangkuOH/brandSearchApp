//
//  AppLogger.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import Foundation
import SwiftUI
import os

/// Usages
/// - debugging
///   logger.debug("debug")
///   logger.info("info")

/// - persisted to disk
///   logger.notice("notice")
///   logger.error("error")
///   logger.fault("fault")
class AppLogger: NSObject {
    static let shared: AppLogger = AppLogger()

    let logger = Logger(subsystem: Constant.clientId, category: Constant.targetName)
    let signpostLog = OSLog(__subsystem: Constant.clientId, category: Constant.targetName)
}

extension AppLogger {

    func debug(_ message: String) {
        logger.debug("➡️ debug: \(message)")
    }
    
    func debug(_ format: String, _ args: Any...) {
        logger.debug("➡️ debug: \(String(format: format, args) )")
    }

    func info(_ message: String) {
        logger.info("📗 info: \(message)")
    }
    
    func info(_ format: String, _ args: Any...) {
        logger.info("📗 info: \(String(format: format, args) )")
    }

    func notice(_ message: String) {
        logger.notice("📘 notice: \(message)")
    }
    
    func notice(_ format: String, _ args: Any...) {
        logger.notice("📘 notice: \(String(format: format, args) )")
    }

    func error(_ message: String) {
        logger.error("📕 error: \(message)")
    }
    
    func error(_ format: String, _ args: Any...) {
        logger.error("📕 error: \(String(format: format, args) )")
    }

    func fault(_ message: String) {
        logger.fault("📔 fault: \(message, privacy: .public)")
    }
    
    func fault(_ format: String, _ args: Any...) {
        logger.fault("📔 fault: \(String(format: format, args), privacy: .public)")
    }
}


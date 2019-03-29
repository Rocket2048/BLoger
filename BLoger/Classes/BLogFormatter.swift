//
//  BLogFormatter.swift
//  BLoger
//
//  Created by lin bo on 2019/2/13.
//  Copyright © 2019 lin bo. All rights reserved.
//

import UIKit
import CocoaLumberjack

enum BLogFlag: String {
    
    case verbose    = "v"
    case debug      = "d"
    case info       = "i"
    case warning    = "w"
    case error      = "e"
    case `guard`    = "g"
    case none       = "-"
    
    /// 返回一个简化的标记: v/d/i...
    public static func flagString(_ log: DDLogMessage) -> String {
        
        if let tag = log.tag as? String, tag == "guard" {
            return BLogFlag.guard.rawValue
        }
        if let tag = log.tag as? String, tag == "none" {
            return BLogFlag.none.rawValue
        }

        let flag = log.flag

        switch flag {
        case DDLogFlag.verbose:
            return BLogFlag.verbose.rawValue
        case DDLogFlag.debug:
            return BLogFlag.debug.rawValue
        case DDLogFlag.info:
            return BLogFlag.info.rawValue
        case DDLogFlag.warning:
            return BLogFlag.warning.rawValue
        case DDLogFlag.error:
            return BLogFlag.error.rawValue
        default:
            return BLogFlag.none.rawValue
        }
    }
    
    /// 时间格式
    static fileprivate func dateToLocalStr(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        
        return formatter.string(from: date)
    }
    
    /// 方法名简化
    static fileprivate func funcCut(_ funcStr: String?) -> String {
        
        guard let funcStr = funcStr else {
            return "-"
        }
        
        guard let range = funcStr.range(of: "(") else {
            return funcStr
        }
        
        return String(funcStr[funcStr.startIndex ..< range.lowerBound])
    }
}

class BLogFormatter: NSObject, DDLogFormatter {

    // 继承 重写格式
    func format(message logMessage: DDLogMessage) -> String? {
        
        let funcStr = BLogFlag.funcCut(logMessage.function)

        return "--[\(BLogFlag.flagString(logMessage)) \(logMessage.fileName) \(funcStr) L:\(logMessage.line)] \(logMessage.message)"
    }
}

class JYFileLogFormatter: NSObject, DDLogFormatter {
    
    // 继承 重写格式
    func format(message logMessage: DDLogMessage) -> String? {
        
        let dateStr = BLogFlag.dateToLocalStr(logMessage.timestamp)
        
        let funcStr = BLogFlag.funcCut(logMessage.function)
        
        let message = BLoger.convertMessage(msg: logMessage.message)

        return "--[\(BLogFlag.flagString(logMessage)) \(dateStr) \(logMessage.fileName) \(funcStr) L:\(logMessage.line)] \(message)"
    }
}

class JYFileLogFormatter2: NSObject, DDLogFormatter {

    // 继承 重写格式
    func format(message logMessage: DDLogMessage) -> String? {
        
        let dateStr = BLogFlag.dateToLocalStr(logMessage.timestamp)
        
        let funcStr = BLogFlag.funcCut(logMessage.function)
        
        let message = BLoger.convertMessage(msg: logMessage.message)
        
        return "--[\(BLogFlag.flagString(logMessage)) \(dateStr) \(logMessage.fileName) \(funcStr) L:\(logMessage.line)] \(message)"
    }
}

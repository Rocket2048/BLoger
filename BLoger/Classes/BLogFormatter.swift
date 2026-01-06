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
    
    case verbose    = "1"
    case debug      = "2"
    case info       = "3"
    case warning    = "4"
    case error      = "5"
    case none       = "0"
    
    public var flag: String {
        
        switch self {
        case .verbose:
            return "🍏"
        case .debug:
            return "🛠"
        case .info:
            return "🥏"
        case .warning:
            return "⚠️"
        case .error:
            return "🚫"
        case .none:
            return "➡️"
        }
    }
    
    /// 返回一个简化的标记
    public static func flag(_ log: DDLogMessage) -> BLogFlag {

        if let tag = log.representedObject as? String, tag == "none" {
            return BLogFlag.none
        }

        let flag = log.flag

        switch flag {
        case DDLogFlag.verbose:
            return BLogFlag.verbose
        case DDLogFlag.debug:
            return BLogFlag.debug
        case DDLogFlag.info:
            return BLogFlag.info
        case DDLogFlag.warning:
            return BLogFlag.warning
        case DDLogFlag.error:
            return BLogFlag.error
        default:
            return BLogFlag.none
        }
    }

    /// 时间格式
    static fileprivate func dateToLocalStr(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.dateFormat = "yyMMdd.HHmmss"
        
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

        return "\(BLogFlag.flag(logMessage).flag)[\(BLogFlag.flag(logMessage).rawValue) \(logMessage.fileName) \(funcStr) L:\(logMessage.line)] \(logMessage.message)"
    }
}

class JYFileLogFormatter: NSObject, DDLogFormatter {
    
    // 继承 重写格式
    func format(message logMessage: DDLogMessage) -> String? {
        
        let dateStr = BLogFlag.dateToLocalStr(logMessage.timestamp)
        
        let funcStr = BLogFlag.funcCut(logMessage.function)
        
        let message = BLoger.convertMessage(msg: logMessage.message)

        return "\(BLogFlag.flag(logMessage).flag)[\(BLogFlag.flag(logMessage).rawValue) \(dateStr) \(logMessage.fileName) \(funcStr) L:\(logMessage.line)] \(message)"
    }
}

class JYFileLogFormatter2: NSObject, DDLogFormatter {

    // 继承 重写格式
    func format(message logMessage: DDLogMessage) -> String? {
        
        let dateStr = BLogFlag.dateToLocalStr(logMessage.timestamp)
        
        let funcStr = BLogFlag.funcCut(logMessage.function)
        
        let message = BLoger.convertMessage(msg: logMessage.message)
        
        return "\(BLogFlag.flag(logMessage).flag)[\(BLogFlag.flag(logMessage).rawValue) \(dateStr) \(logMessage.fileName) \(funcStr) L:\(logMessage.line)] \(message)"
    }
}

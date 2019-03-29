//
//  BLogDefine.swift
//  BLoger
//
//  Created by lin bo on 2019/3/21.
//  Copyright © 2019 lin bo. All rights reserved.
//

import Foundation
import CocoaLumberjack

public let DDDefaultLogLevel: DDLogLevel = .all

/// Common
fileprivate func _BLog(_ message: @autoclosure () -> String,
                       level: DDLogLevel = DDDefaultLogLevel,
                       flag: DDLogFlag,
                       context: Int = 0,
                       file: StaticString = #file,
                       function: StaticString = #function,
                       line: UInt = #line,
                       tag: Any? = nil,
                       asynchronous async: Bool = false,
                       ddlog: DDLog = .sharedInstance) {
    
    _DDLogMessage(message, level: level, flag: flag, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Default (Verbose)
public func BLog(_ message: @autoclosure () -> String = "-",
                 level: DDLogLevel = DDDefaultLogLevel,
                 context: Int = 0,
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line,
                 tag: Any? = nil,
                 asynchronous async: Bool = false,
                 ddlog: DDLog = .sharedInstance) {
    _BLog(message, level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: "none", asynchronous: async, ddlog: ddlog)
}

/// Verbose
public func BLog_v(_ verbose: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(verbose, level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Debug
public func BLog_d(_ debug: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(debug, level: level, flag: .debug, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Info
public func BLog_i(_ info: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(info, level: level, flag: .info, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Guard (info)
public func BLog_g(_ `guard`: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(`guard`, level: level, flag: .info, context: context, file: file, function: function, line: line, tag: "guard", asynchronous: async, ddlog: ddlog)
}

/// Warning
public func BLog_w(_ warning: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(warning, level: level, flag: .warning, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Error
public func BLog_e(_ error: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(error, level: level, flag: .error, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

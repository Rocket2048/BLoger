//
//  Utils.swift
//  BLoger_Example
//
//  Created by lin bo on 2019/7/8.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import BLoger

/// 推荐使用下列方法来输出，可以避免每次都import BLoger（建议使用）
public func ALog(_ message: @autoclosure () -> String = "-",
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) {
    BLog(message(), file: file, function: function, line: line)
}

public func VLog(_ message: @autoclosure () -> String = "-",
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) {
    BLog_v(message(), file: file, function: function, line: line)
}

public func DLog(_ message: @autoclosure () -> String = "-",
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) {
    BLog_d(message(), file: file, function: function, line: line)
}

public func ILog(_ message: @autoclosure () -> String = "-",
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) {
    BLog_i(message(), file: file, function: function, line: line)
}

public func WLog(_ message: @autoclosure () -> String = "-",
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) {
    BLog_w(message(), file: file, function: function, line: line)
}

public func ELog(_ message: @autoclosure () -> String = "-",
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) {
    BLog_e(message(), file: file, function: function, line: line)
}

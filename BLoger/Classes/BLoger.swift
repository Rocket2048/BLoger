//
//  BLoger.swift
//  BLoger
//
//  Created by lin bo on 2019/2/13.
//  Copyright © 2019 lin bo. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

public class BLoger {
    
    public static let shared = BLoger()
    
    init() {

        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 摇一摇显示
    public var shankShow = false
    
    /// 弹出式LogView
    fileprivate var logView: BLogView = {
        
        let view = BLogView()
        return view
    }()
    
    /// 第一个File Logger 所有都接收
    public let fileLogger: DDFileLogger = {
        
        let fileLogger = DDFileLogger()
        let fileFormat = JYFileLogFormatter()
        fileLogger.logFormatter = fileFormat
        
        return fileLogger
    }()
    
    /// 第二个File Logger 只接收错误和警告 并长期存储
    public let fileLogger2: DDFileLogger = {
        
        let path = "\(NSHomeDirectory())/Library/Preferences/Logs"
        if FileManager.default.fileExists(atPath: path) == false {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        let manager = DDLogFileManagerDefault(logsDirectory: path)
        let fileLogger = DDFileLogger.init(logFileManager: manager)
        let fileFormat = JYFileLogFormatter2()
        fileLogger.logFormatter = fileFormat
        
        return fileLogger
    }()

    /// 控制输出到文件每条的Message最大字符数
    private var maxMessageSize: UInt = 0
    
    /// 开启（配置）
    public func start(_ config: BLogConfig = BLogConfig()) {
        
        let format = BLogFormatter()
        /// 下面功能有待确认，请忽略
        // DDTTYLogger.sharedInstance.logFormatter = format
        // DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console

        DDASLLogger.sharedInstance.logFormatter = format
        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
        
        DDLog.add(fileLogger, with: .all)
        fileLogger.maximumFileSize = config.maximumFileSize
        fileLogger.logFileManager.maximumNumberOfLogFiles = config.maximumNumberOfLogFiles
        
        DDLog.add(fileLogger2, with: .warning)
        fileLogger2.maximumFileSize = config.maximumFileSize
        fileLogger2.logFileManager.maximumNumberOfLogFiles = config.maximumNumberOfLogFiles
        
        maxMessageSize = config.maxMessageSize
    }
    
    /// 显示Log View
    public func showLogView(_ inView: UIView? = nil) {
    
        logView.show(inView: inView)
    }
    
    /// 隐藏Log View
    public func dismissLogView() {
        
        logView.dismiss()
    }
    
    /// 获取当前日志（字符串）
    func getNewDoc() -> String? {
        
        guard let path = BLoger.shared.fileLogger.currentLogFileInfo?.filePath else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        let str = String.init(data: data, encoding: .utf8)
        return str
    }
    
    /// 设置message长度后需要处理message的格式
    static func convertMessage(msg :String) -> String {
        
        if BLoger.shared.maxMessageSize == 0 {
            return msg
        }
        
        let msg = msg.replacingOccurrences(of: "\n", with: " ")

        if msg.count <= BLoger.shared.maxMessageSize {
            return msg
        }
        return "\(String(msg.prefix(Int(BLoger.shared.maxMessageSize))))...\(msg.count)"
    }
    
    @objc fileprivate func receivedRotation() {
        
        logView.adapterScreen()
    }
}

public class BLogConfig {
    
    public init() {
        
    }
    
    /// 每个文件大小
    public var maximumFileSize: UInt64 = 1024*1024
    
    /// 缓存几个文件
    public var maximumNumberOfLogFiles: UInt = 30
    
    /// 信息长度限制大于0时，回车转空格; 若设置为0，则不限制; 仅限制Log文件s格式，不限制控制台输出
    public var maxMessageSize: UInt = 0
    
}

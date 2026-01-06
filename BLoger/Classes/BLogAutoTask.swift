//
//  BLogAutoTask.swift
//  BLoger
//
//  Created by lin bo on 2019/3/20.
//  Copyright © lin bo. All rights reserved.
//

// 定时器每秒随机生成一条数据
import UIKit

public class BLogAutoTask {
    
    public static let shared = BLogAutoTask()
    
    public private(set) var started = false
    
    fileprivate var timer: Timer?
    
    /// 开始自动输出(请测试的时候下使用，无实际意义)
    ///
    /// - Parameter interval: 间隔
    public func start(_ interval: TimeInterval = 1.0) {

        stop()
        
        started = true
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(repet), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    /// 停止
    public func stop() {
        
        started = false
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc private func repet() {
        
        let random = arc4random() % 7
        
        switch random {
        case 0:
            BLog("\(random)")
        case 1:
            BLog_v("\(random)")
        case 2:
            BLog_d("\(random)")
        case 3:
            BLog_i("\(random)")
        case 4:
            BLog_w("\(random)")
        case 5:
            BLog_e("\(random)")
        default:
            BLog("\(random)")
        }
    }

}

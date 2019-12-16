//
//  AppDelegate.swift
//  BLoger
//
//  Created by ok@linbok.com on 03/26/2019.
//  Copyright (c) 2019 ok@linbok.com. All rights reserved.
//

import UIKit
import BLoger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// ------------------------以下是我们需要配置的
        
        /// 可以使用这个做些配置（可选）
        let config = BLogConfig()
        
        /// 每条message最大字符限制,会把回车转空格（这个功能主要目的是限制每条日志长度，控制日志格式，但缺点是降低可读性）
        // config.maxMessageSize = 500
        
        /// 表示我已经启动
        BLoger.shared.start(config)
        
        /// Debug模式下开启摇一摇弹出功能（Release禁用哟！）（建议使用）
        /// 请注意Swift下DEBUG判断无效 需要添加如下：
        /// Build Settings -> Swift Compiler - Custom Flags -> Other Swift Flages -> Debug的路径下加入-D DEBUG
        #if DEBUG
        BLoger.shared.shankShow = true
        ALog("Debug")
        #else
        BLoger.shared.shankShow = false
        ALog("Not Debug")
        #endif

        /// ------------------------以上是全部我们需要配置的

        /// ------------------------以下属于测试Demo的功能
        
        /// 开启自动输出日志（这个功能会持续输出日志，给Demo测试用的）
        BLogAutoTask.shared.start()

        ALog("------------启动应用---------------")
        BLog("这是打开应用第一条输出")

        /// 以下验证日志格式（推荐使用ALog转换后的方法，避免每次import库）
        ALog()
        VLog("Verbose")
        DLog("Debug")
        ILog("Info")
        WLog("Warn")
        ELog("Error")
        ALog("abcdefg")
        ILog(BLoger.shared.fileLogger.currentLogFileInfo.description) // Log文件信息
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        ALog("------------切到后台---------------")

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        ALog("------------切到前端---------------")

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


# BLoger

[![CI Status](https://img.shields.io/travis/ok@linbok.com/BLoger.svg?style=flat)](https://travis-ci.org/ok@linbok.com/BLoger)
[![Version](https://img.shields.io/cocoapods/v/BLoger.svg?style=flat)](https://cocoapods.org/pods/BLoger)
[![License](https://img.shields.io/cocoapods/l/BLoger.svg?style=flat)](https://cocoapods.org/pods/BLoger)
[![Platform](https://img.shields.io/cocoapods/p/BLoger.svg?style=flat)](https://cocoapods.org/pods/BLoger)
[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)
[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)

# Demo screenshot

<table><tr>
<td><img src="https://github.com/iosBob/BLDoc/blob/master/BLoger/bl003.GIF" width="375"/></td>
</tr></table>


# How to use


AppDelegate application func Initialization BLoger

code in Appdelegate
```swift

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

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BLoger is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BLoger'
```

## Author

linbo, ok@linbok.com

## License

BLoger is available under the MIT license. See the LICENSE file for more info.

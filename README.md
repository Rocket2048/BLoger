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

```swift
        // 初始化LOG
        let config = BLogConfig()
        // config.maxMessageSize = 500 // 每条message最大字符限制,会把回车转空格
        BLoger.shared.start(config)
        BLoger.shared.shankShow = true // 摇一摇显示LogView
        
        // 验证日志格式
        BLog()
        BLog_v("Verbose")
        BLog_d("Debug")
        BLog_i("Info")
        BLog_w("Warn")
        BLog_e("Error")
        BLog_g()
        
        BLog("------------启动应用---------------")
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

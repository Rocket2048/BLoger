#
# Be sure to run `pod lib lint BLoger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BLoger'
  s.version          = '1.0.0'
  s.summary          = 'A Loger Demo of CocoaLumberjack/Swift'
  s.swift_version    = '4.0'

  s.description      = <<-DESC
A Loger Demo of CocoaLumberjack/Swift.
                       DESC

  s.homepage         = 'https://github.com/iosBob/BLoger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linbo' => 'ok@linbok.com' }
  s.source           = { :git => 'https://github.com/iosBob/BLoger.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'
  s.source_files = 'BLoger/Classes/**/*'

  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'CocoaLumberjack/Swift'
  s.dependency 'SnapKit'
  
end

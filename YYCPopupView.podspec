#
# Be sure to run `pod lib lint YYCPopupView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YYCPopupView'
  s.version          = '0.1.0'
  s.summary          = 'YYCPopupView是一个简单的弹窗组件，实现了弹窗视图的基本属性和行为，将弹窗界面分为三个部分顶部标题视图，中部内容视图，底部按钮视图。可通过指定自定义属性值、重写需要override的方法扩展YYCPopupView基类。组件中包括三个部分：YYCPopupView基类、YYCPopupView的子类、调用YYCPopupView进行弹窗的工厂类YYCPopupViewFactory。YYCPopupView的子类扩展了YYCPopupView的功能，如YYCPopupAlertView实现了简单的文字警告弹窗。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/IPetPlatform/YYCPopupView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'troyan1989' => 'troyan07me@163.com' }
  s.source           = { :git => 'https://github.com/IPetPlatform/YYCPopupView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YYCPopupView/Classes/**/*'
  
  s.resource_bundles = {
    'YYCPopupView' => ['YYCPopupView/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Masonry', '~> 1.0'
end

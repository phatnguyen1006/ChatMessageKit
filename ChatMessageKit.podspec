#
#  Be sure to run `pod spec lint ChatMessageKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name = 'ChatMessageKit'
   s.version = '0.1.1'
   s.license = { :type => "MIT", :file => "LICENSE.md" }

   s.summary = 'An elegant messages UI library for iOS.'
   s.homepage = 'https://github.com/MessageKit/MessageKit'
   s.authors = { "P" => "phatnguyen876@gmail.com", "KhoiLe" => "khoilencontact@gmail.com" }

   s.source = { :git => 'https://github.com/phatnguyen1006/ChatMessageKit.git', :branch => "main", :tag => s.version }
   s.source_files = 'Sources/**/*.{swift}'

   s.swift_version = '5.5'

   s.ios.deployment_target = '12.0'
   s.ios.resources = 'Sources/Assets.xcassets'

   s.dependency 'InputBarAccessoryView', '~> 5.5.0'
end

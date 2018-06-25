#
# Be sure to run `pod lib lint SNHorizontalMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNHorizontalMenu'
  s.version          = '0.2.0'
  s.summary          = 'SNHorizontalMenu is a subclass of UICollectionView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Leverages the power of the UICollectionView to create a horizontal menu'

  s.homepage         = 'https://github.com/stefandragosnitu/SNHorizontalMenu.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stefan Dragos Nitu' => 'nitustefandragos@gmail.com' }
  s.source           = { :git => 'https://github.com/stefandragosnitu/SNHorizontalMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.1'

  s.source_files = 'SNHorizontalMenu/Classes/*.swift'
  # s.resource_bundles = {
  #   'SNHorizontalMenu' => ['SNHorizontalMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

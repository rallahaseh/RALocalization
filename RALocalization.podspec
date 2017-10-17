#
# Be sure to run `pod lib lint RALocalization.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RALocalization'
  s.version          = '0.1.0'
  s.summary          = 'RALocalization provides simple yet robust right-to-left(RTL) capability for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RALocalization is a simple framework that improves localization in Swift iOS apps - providing cleaner syntax and in-app language switching.
                       DESC

  s.homepage         = 'https://github.com/rallahaseh/RALocalization'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rallahaseh' => 'rallahaseh@gmail.com' }
  s.source           = { :git => 'https://github.com/rallahaseh/RALocalization.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rallahaseh'

  s.ios.deployment_target = '8.0'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  s.source_files = 'RALocalization/Classes/**/*'

end

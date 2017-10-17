# RALocalization

[![CI Status](http://img.shields.io/travis/rallahaseh/RALocalization.svg?style=flat)](https://travis-ci.org/rallahaseh/RALocalization)
[![Version](https://img.shields.io/cocoapods/v/RALocalization.svg?style=flat)](http://cocoapods.org/pods/RALocalization)
[![License](https://img.shields.io/cocoapods/l/RALocalization.svg?style=flat)](http://cocoapods.org/pods/RALocalization)
[![Platform](https://img.shields.io/cocoapods/p/RALocalization.svg?style=flat)](http://cocoapods.org/pods/RALocalization)

RALocalization is a simple framework that improves localization in Swift iOS apps - providing cleaner syntax and in-app language switching

<br>
<img src="https://media.giphy.com/media/26n7aMoR9RbXCLnR6/giphy.gif"/>
<br>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage
If Cocapod

```swift
import RALocalization
```

Add `.swizzleClassesMethods()` in AppDelegate, setter RTL methods
```swift
RALocalizer.swizzleClassesMethods()
```

For change language use `.setLanguage(language: *required language*)`
Example:
```swift
RALanguage.setLanguage(language: .hebrew)
```

## Installation

RALocalization is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RALocalization'
```

## Author

rallahaseh, rallahaseh@gmail.com

## License

RALocalization is available under the MIT license. See the LICENSE file for more info.

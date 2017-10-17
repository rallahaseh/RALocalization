//
//  RALocalizer.swift
//  RALocalization
//
//  Created by Rashed Al Lahaseh on 10/17/17.
//

import UIKit

open class RALocalizer: NSObject {
    
    open class func swizzleClassesMethods() {
        swizzleMethods(cls: Bundle.self,
                       originalSelector: #selector(Bundle.localizedString(forKey:value:table:)),
                       overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        
        swizzleMethods(cls: UIApplication.self,
                       originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection),
                       overrideSelector: #selector(getter: UIApplication.customUserInterfaceLayoutDirection))
        
        swizzleMethods(cls: UITextField.self,
                       originalSelector: #selector(UITextField.layoutSubviews),
                       overrideSelector: #selector(UITextField.customLayoutSubviews))
        
        swizzleMethods(cls: UILabel.self,
                       originalSelector: #selector(UILabel.layoutSubviews),
                       overrideSelector: #selector(UILabel.customLayoutSubviews))
        
        swizzleMethods(cls: UIImageView.self,
                       originalSelector: #selector(UIImageView.layoutSubviews),
                       overrideSelector: #selector(UIImageView.customLayoutSubviews))
    }
}

/// Exchange the implementation of two methods of the same Class
func swizzleMethods(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let originalMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls,
                            overrideSelector,
                            method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

func disableswizzleMethods() {}

extension UIViewController {
    
    // Tag your subviews with tag < 0 and get them flipped
    open func subviewsRTLImages() {
        if RALanguage.currentLanguage() == RALanguages.arabic.rawValue {
            getThroughSubViews(subViews: self.view.subviews)
        } else if RALanguage.currentLanguage() == RALanguages.hebrew.rawValue {
            getThroughSubViews(subViews: self.view.subviews)
        }
    }
    // Make a loop to get through sub views and flip the images(mirrored)
    // Only flip the UIImageViews with [tag < 0], if you have images doesn't need RTL -> [tag > 0]
    func getThroughSubViews(subViews: [UIView]) {
        if subViews.count > 0 {
            for subView in subViews {
                if subView is UIImageView && subView.tag < 0 {
                    let right = subView as! UIImageView
                    if let img = right.image {
                        right.image = UIImage(cgImage: img.cgImage!, scale: img.scale, orientation: .upMirrored)
                    }
                }
                getThroughSubViews(subViews: subView.subviews)
            }
        }
    }
}

extension UIImageView {
    @objc public func customLayoutSubviews() {
        if RALanguage.currentLanguage() == RALanguages.arabic.rawValue {
            self.transform = CGAffineTransform(scaleX: -1, y: 1);
        } else if RALanguage.currentLanguage() == RALanguages.hebrew.rawValue {
            self.transform = CGAffineTransform(scaleX: -1, y: 1);
        }
    }
}
extension UILabel {
    open func setLocalizedText(text: String) {
        //        self.setLocalizedText(text: text)
        // Set custom font to all the labels maintaining the size UILabel
        self.font = UIFont(name: FONT_TYPE, size: self.font.pointSize)
        // Direct Change
        self.text = NSLocalizedString(text, comment: text)
    }
    
    @objc public func customLayoutSubviews() {
        self.customLayoutSubviews()
        
        // Handle Special Case with UITextFields
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) { return }
        
        if self.tag <= 0 {
            if UIApplication.isRTL() {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}

extension UITextField {
    @objc public func customLayoutSubviews() {
        self.customLayoutSubviews()
        if self.tag <= 0 {
            if UIApplication.isRTL()  {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}

extension UIApplication {
    class func isRTL() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    @objc var customUserInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if RALanguage.currentLanguage() == RALanguages.arabic.rawValue {
                direction = .rightToLeft
            } else if RALanguage.currentLanguage() == RALanguages.hebrew.rawValue {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = RALanguage.currentLanguage()
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: RALanguage.currentLanguage(withLocale: false), ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }else
                if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                    bundle = Bundle(path: _path)!
                } else {
                    let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                    bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

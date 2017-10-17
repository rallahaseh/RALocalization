//
//  ViewController.swift
//  RALocalization
//
//  Created by rallahaseh on 10/17/2017.
//  Copyright (c) 2017 rallahaseh. All rights reserved.
//

import UIKit
import RALocalization

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.button.titleLabel?.text = NSLocalizedString("changeLanguage", comment: "Change Language")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        let actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertControllerStyle.actionSheet)
        let availableLanguages = ["English", "אנגלית", "العربية"]
        for language in availableLanguages {
            let displayName = language
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                if language == "English" {
                    RALanguage.setLanguage(language: .english)
                    transition = .transitionFlipFromRight
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                } else if language == "العربية" {
                    RALanguage.setLanguage(language: .arabic)
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                } else {
                    transition = .transitionCurlUp
                    RALanguage.setLanguage(language: .hebrew)
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                }
                let rootVC: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                rootVC.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "root")
                let mainWindow = (UIApplication.shared.delegate?.window!)!
                mainWindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
                UIView.transition(with: mainWindow, duration: 0.55001, options: transition, animations: { () -> Void in
                }) { (finished) -> Void in}
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)

    }

}


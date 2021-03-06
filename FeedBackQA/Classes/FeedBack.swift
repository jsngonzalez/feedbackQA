//
//  FeedBack.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import Foundation
import UIKit

open class FeedBack {
    private (set) var appid: String?
    private (set) var appversion: String?
    
    public init(appid: String) {
        self.appid = appid
        self.appversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.listenForScreenshot()
    }
    
    public init(appid: String, andVersion version:String) {
        self.appid = appid
        self.appversion = version
        
        self.listenForScreenshot()
    }
    
    
    private func listenForScreenshot() {
        
        #if swift(<4.2)
            let name = NSNotification.Name.UIApplicationUserDidTakeScreenshot
        #else
            let name = UIApplication.userDidTakeScreenshotNotification
        #endif
        
        
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main) { notification in
            self.display(viewController: nil, shouldFetchScreenshot: true)
        }
    }
    
    public func display(viewController: UIViewController? = nil, shouldFetchScreenshot: Bool = false) {
        guard let topmostViewController = UIViewController.topmostViewController else {
            fatalError("No view controller to present FeedbackManager on")
        }
        
        // Don't allow the the UI to be presented if it's already the top VC
        if topmostViewController is InicioFeeBack {
            return
        }
        
        let controller = InicioFeeBack.getController()
        let screenshot = topmostViewController.screenshot()
        controller.imgScreenshot = screenshot
        controller.appid = appid ?? ""
        controller.appversion = appversion ?? ""
        topmostViewController.present(controller, animated: true, completion: {
          controller.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
        })
    }
}

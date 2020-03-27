//
//  FeedBack.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import Foundation
import UIKit

open class FeedBack {
    private (set) var token: String?
    
    public init(token: String) {
        self.token = token
        self.listenForScreenshot()
    }
    
    private func listenForScreenshot() {
        let name = NSNotification.Name.UIApplicationUserDidTakeScreenshot
        
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
        topmostViewController.present(controller, animated: true, completion: nil)
    }
}

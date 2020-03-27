//
//  BlinkingLabel.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import UIKit

public extension UIView {
    
    func fadeIn(){
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha=1
        }, completion: nil)
    }
    func fadeOut(){
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha=0
        }, completion: nil)
    }
    
    func screenshot() -> UIImage {
        let imageSize = UIScreen.main.bounds.size as CGSize;
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for obj : AnyObject in UIApplication.shared.windows {
            if let window = obj as? UIWindow {
                if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                    context!.saveGState();
                    context!.translateBy(x: window.center.x, y: window.center.y);
                    context!.concatenate(window.transform);
                    context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x, y: -window.bounds.size.height * window.layer.anchorPoint.y);
                    window.layer.render(in: context!)
                    context!.restoreGState();
                }
            }
        }
        let image = UIGraphicsGetImageFromCurrentImageContext();
        return image!
    }
}

//
//  UIViewControllerExtension.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import Foundation


extension UIViewController {
    
    static var topmostViewController: UIViewController? {
        var vc: UIViewController?
        
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        
        vc = rootViewController
        
        while let presentedViewController = vc?.presentedViewController {
            vc = presentedViewController
        }
        
        return vc
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

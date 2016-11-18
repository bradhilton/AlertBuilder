//
//  AlertController.swift
//  Pods
//
//  Created by Bradley Hilton on 3/23/16.
//
//

private var topViewController: UIViewController? {
    return topViewController(UIApplication.shared.delegate?.window??.rootViewController)
}

private func topViewController(_ viewController: UIViewController?) -> UIViewController? {
    if let viewController = viewController as? UINavigationController {
        return topViewController(viewController.visibleViewController)
    } else if let tabBarController = viewController as? UITabBarController {
        let moreNavigationController = tabBarController.moreNavigationController
        if let viewController = moreNavigationController.topViewController, viewController.view.window != nil {
            return topViewController(viewController)
        } else if let viewController = tabBarController.selectedViewController {
            return topViewController(viewController)
        }
    } else if let viewController = viewController?.presentedViewController {
        return topViewController(viewController)
    }
    return viewController
}

private class ViewController : UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? false
    }
    
}

private let window: UIWindow = {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = ViewController()
    window.tintColor = UIApplication.shared.delegate?.window??.tintColor
    return window
}()

private var queue: [AlertController] = []

open class AlertController : UIAlertController {
    
    open func show() {
        if UIDevice.current.userInterfaceIdiom == .pad && preferredStyle == .actionSheet {
            topViewController?.present(self, animated: true, completion: nil)
        } else {
            let topWindowLevel = UIApplication.shared.windows.last?.windowLevel ?? 0
            window.windowLevel = topWindowLevel + 1
            window.makeKeyAndVisible()
            if window.rootViewController?.presentedViewController != nil {
                queue.append(self)
            } else {
                window.rootViewController?.present(self, animated: true, completion: nil)
            }
        }
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if queue.isEmpty {
            UIApplication.shared.delegate?.window??.makeKeyAndVisible()
            window.isHidden = true
        } else {
            window.rootViewController?.present(queue.removeFirst(), animated: true, completion: nil)
        }
    }
    
}

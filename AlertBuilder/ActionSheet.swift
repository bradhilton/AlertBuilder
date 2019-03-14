//
//  ActionSheet.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

public struct ActionSheet : AlertBuilder {
    
    public var configuration = AlertControllerConfiguration()
    
    public init(title: String? = nil, message: String? = nil, cancelable: Bool = true) {
        initialize(title: title, message: message, style: .actionSheet, cancelable: cancelable)
    }
    
    public func barButtonItem(_ barButtonItem: UIBarButtonItem) -> ActionSheet {
        return modify { (config: inout AlertControllerConfiguration) in config.barButtonItem = barButtonItem }
    }
    
    public func sourceView(_ sourceView: UIView, sourceRect: CGRect) -> ActionSheet {
        return modify { (config: inout AlertControllerConfiguration) in
            config.sourceView = sourceView
            config.sourceRect = sourceRect
        }
    }
    
    @discardableResult
    public func presentFrom(_ viewController: UIViewController?) -> AlertController {
        let controller = create()
        viewController?.present(controller, animated: true, completion: nil)
        return controller
    }
    
}

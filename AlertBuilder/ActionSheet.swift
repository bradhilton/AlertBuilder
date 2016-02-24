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
        initialize(title: title, message: message, cancelable: cancelable)
    }
    
    public func barButtonItem(barButtonItem: UIBarButtonItem) -> ActionSheet {
        return modify { (inout config: AlertControllerConfiguration) in
            config.barButtonItem = barButtonItem
            config.preferredStyle = .ActionSheet
        }
    }
    
    public func sourceView(sourceView: UIView, sourceRect: CGRect) -> ActionSheet {
        return modify { (inout config: AlertControllerConfiguration) in
            config.sourceView = sourceView
            config.sourceRect = sourceRect
            config.preferredStyle = .ActionSheet
        }
    }
    
}
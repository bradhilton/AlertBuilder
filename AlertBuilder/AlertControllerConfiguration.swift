//
//  AlertControllerConfiguration.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/24/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

struct Action {
    
    let style: UIAlertActionStyle
    let enabled: Bool
    let image: UIImage?
    let handler: ActionHandler?
    
}

class TextField {
    
    let configuration: TextFieldConfiguration?
    var observer: TextFieldHandler?
    
    init(configuration: TextFieldConfiguration?) {
        self.configuration = configuration
    }
    
}

public struct AlertControllerConfiguration {
    
    var actions: [(String, Action)] = []
    var preferredAction: String?
    var textFields: [(String , TextField)] = []
    var title: String?
    var message: String?
    var view: UIView?
    var style: UIAlertControllerStyle = .alert
    var barButtonItem: UIBarButtonItem?
    var sourceView: UIView?
    var sourceRect: CGRect = CGRect.zero
    
}

//
//  AlertContext.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/24/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

public protocol AlertContext {
    var controller: UIAlertController { get }
}

extension AlertContext {
    
    var actions: [String : UIAlertAction] {
        return controller.actions.reduce([:]) {
            if let title = $1.title {
                var actions = $0
                actions[title] = $1
                return actions
            }
            return $0
        }
    }
    
    var textFields: [String : UITextField] {
        return (controller.textFields ?? []).reduce([:]) {
            if let placeholder = $1.placeholder {
                var actions = $0
                actions[placeholder] = $1
                return actions
            }
            return $0
        }
    }
    
    
}



public struct AlertActionContext : AlertContext {
    public let action: UIAlertAction
    public let controller: UIAlertController
}

public struct AlertTextFieldContext : AlertContext {
    public let placeholder: String
    public let textField: UITextField
    public let controller: UIAlertController
}


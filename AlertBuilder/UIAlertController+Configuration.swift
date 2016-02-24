//
//  UIAlertController+Extension.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import SwiftCallbacks

extension UIAlertController {
    
    convenience init(configuration: AlertControllerConfiguration) {
        self.init(title: configuration.title, message: configuration.message, preferredStyle: configuration.preferredStyle)
        for (title, action) in configuration.actions {
            let alertAction = UIAlertAction(title: title, style: action.style) { [weak self] alertAction in
                if let this = self {
                    action.handler?(context: AlertActionContext(action: alertAction, controller: this))
                }
            }
            alertAction.enabled = action.enabled
            addAction(alertAction)
        }
        if let preferredAction = configuration.preferredAction {
            self.preferredAction = actions.find { $0.title == preferredAction }
        }
        for (placeholder, textField) in configuration.textFields {
            addTextFieldWithConfigurationHandler {
                $0.placeholder = placeholder
                textField.configuration?(textField: $0)
                $0.controlEvents(.EditingChanged) { [weak self] (sender: UITextField) in
                    guard let this = self else { return }
                    textField.observer?(context: AlertTextFieldContext(placeholder: placeholder, textField: sender, controller: this))
                }
            }
        }
        popoverPresentationController?.barButtonItem = configuration.barButtonItem
        popoverPresentationController?.sourceView = configuration.sourceView
        popoverPresentationController?.sourceRect = configuration.sourceRect
    }
    
}

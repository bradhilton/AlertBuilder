//
//  UIAlertController+Extension.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import SwiftCallbacks
import Swiftstraints

extension UIAlertController {
    
    convenience init(configuration: AlertControllerConfiguration) {
        let style: UIAlertControllerStyle
        if UIDevice.current.userInterfaceIdiom == .pad
            && configuration.style == .actionSheet
            && configuration.sourceView == nil
            && configuration.barButtonItem == nil {
            style = .alert
        } else {
            style = configuration.style
        }
        self.init(title: configuration.title, message: configuration.message, preferredStyle: style)
        addActions(configuration.actions, preferredAction: configuration.preferredAction)
        addTextFields(configuration.textFields)
        popoverPresentationController?.barButtonItem = configuration.barButtonItem
        popoverPresentationController?.sourceView = configuration.sourceView
        popoverPresentationController?.sourceRect = configuration.sourceRect
        addView(configuration.view)
    }

    fileprivate func addActions(_ actions: [(String, Action)], preferredAction: String?) {
        for (title, action) in actions {
            let alertAction = UIAlertAction(title: title, style: action.style) { [weak self] alertAction in
                if let this = self {
                    action.handler?(AlertActionContext(action: alertAction, controller: this))
                }
            }
            alertAction.isEnabled = action.enabled
            alertAction.setValue(action.image, forKey: "image")
            addAction(alertAction)
        }
        if let preferredAction = preferredAction {
            self.preferredAction = self.actions.find { $0.title == preferredAction }
        }
    }
    
    fileprivate func addTextFields(_ textFields: [(String, TextField)]) {
        for (placeholder, textField) in textFields {
            addTextField {
                $0.placeholder = placeholder
                textField.configuration?($0)
                $0.controlEvents(.editingChanged) { [weak self] (sender: UITextField) in
                    guard let this = self else { return }
                    textField.observer?(AlertTextFieldContext(placeholder: placeholder, textField: sender, controller: this))
                }
            }
        }
    }
    
    fileprivate func addView(_ view: UIView?) {
        guard let view = view else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        if self.title != nil {
            self.view.addConstraint(view.topAnchor == self.view.topAnchor + (self.preferredStyle == .alert ? 32 : 26))
        } else {
            self.view.addConstraint(view.topAnchor == self.view.topAnchor + 8)
            self.title = ""
        }
        for _ in 0..<Int(view.frame.height/(self.preferredStyle == .alert ? 25 : 19)) {
            self.title?.append(Character("\n"))
        }
        self.view.addConstraints("H:|-[\(view)]-|")
    }
    
}

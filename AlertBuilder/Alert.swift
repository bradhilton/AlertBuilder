//
//  Alert.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

public struct Alert : AlertBuilder {
    
    public var configuration = AlertControllerConfiguration()
    
    public init(title: String? = nil, message: String? = nil, cancelable: Bool = true) {
        initialize(title: title, message: message, style: .alert, cancelable: cancelable)
    }
    
    public func textField(placeholder: String, configure: TextFieldConfiguration? = nil) -> Alert {
        return modify { (config: inout AlertControllerConfiguration) in
            config.textFields.append((placeholder, TextField(configuration: configure)))
        }
    }
    
    public func observeTextField(placeholder: String, observer: @escaping TextFieldHandler) -> Alert {
        return modify { (config: inout AlertControllerConfiguration) in
            if let (_, textField) = config.textFields.find(predicate: { $0.0 == placeholder }) {
                textField.observer = observer
            }
        }
    }
    
}

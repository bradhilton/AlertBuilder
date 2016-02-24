//
//  AlertBuilderProtocol.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//


public typealias ActionHandler = (context: AlertActionContext) -> ()
public typealias TextFieldHandler = (context: AlertTextFieldContext) -> ()
public typealias TextFieldConfiguration = (textField: UITextField) -> ()

public protocol AlertBuilder {
    
    var configuration: AlertControllerConfiguration { get set }
    
}

extension AlertBuilder {
    
    mutating func initialize(title title: String?, message: String?, cancelable: Bool) {
        configuration.title = title
        configuration.message = message
        if cancelable {
            self = cancel("Cancel", handler: nil)
        }
    }
    
    public func title(title: String?) -> Self {
        return modify { (inout config: AlertControllerConfiguration) in config.title = title }
    }
    
    public func message(message: String?) -> Self {
        return modify { (inout config: AlertControllerConfiguration) in config.message = message }
    }
    
    public func action(title: String, preferred: Bool = false, enabled: Bool = true, handler: ActionHandler?) -> Self {
        return addAction(title, preferred: preferred, enabled: enabled, handler: handler, style: .Default)
    }
    
    public func destructive(title: String, preferred: Bool = false, enabled: Bool = true, handler: ActionHandler?) -> Self {
        return addAction(title, preferred: preferred, enabled: enabled, handler: handler, style: .Destructive)
    }
    
    public func cancel(title: String, preferred: Bool = false, enabled: Bool = true, handler: ActionHandler? = nil) -> Self {
        return addAction(title, preferred: preferred, enabled: enabled, handler: handler, style: .Cancel)
    }
    
    public func presentFrom(viewController: UIViewController, animated: Bool = true) {
        viewController.presentViewController(UIAlertController(configuration: configuration), animated: animated, completion: nil)
    }
    
    private func addAction(title: String, preferred: Bool, enabled: Bool, handler: ActionHandler?, style: UIAlertActionStyle) -> Self {
        return modify { (inout config: AlertControllerConfiguration) in
            let action = Action(style: style, enabled: enabled, handler: handler)
            config.actions.append((title, action))
            config.preferredAction = preferred ? title : config.preferredAction
        }
    }
    
    func modify(modify: (inout AlertControllerConfiguration) -> ()) -> Self {
        var copy = self
        modify(&copy.configuration)
        return copy
    }
    
}




//
//  AlertBuilderProtocol.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//


public typealias ActionHandler = (_ context: AlertActionContext) -> ()
public typealias TextFieldHandler = (_ context: AlertTextFieldContext) -> ()
public typealias TextFieldConfiguration = (_ textField: UITextField) -> ()

public protocol AlertBuilder {
    
    var configuration: AlertControllerConfiguration { get set }
    
}

extension AlertBuilder {
    
    mutating func initialize(title: String?, message: String?, style: UIAlertControllerStyle, cancelable: Bool) {
        configuration.title = title
        configuration.message = message
        configuration.style = style
        if cancelable {
            self = cancel("Cancel", handler: nil)
        }
    }
    
    public func title(_ title: String?) -> Self {
        return modify { (config: inout AlertControllerConfiguration) in config.title = title }
    }
    
    public func message(_ message: String?) -> Self {
        return modify { (config: inout AlertControllerConfiguration) in config.message = message }
    }
    
    public func view(_ view: UIView?) -> Self {
        return modify { (config: inout AlertControllerConfiguration) in config.view = view }
    }
    
    public func action(_ title: String, preferred: Bool = false, enabled: Bool = true, image: UIImage? = nil, handler: ActionHandler?) -> Self {
        return addAction(title, preferred: preferred, enabled: enabled, image: image, handler: handler, style: .default)
    }
    
    public func actions(_ titles: [String], preferred: Bool = false, enabled: Bool = true, handler: ActionHandler?) -> Self {
        return titles.reduce(self) { $0.addAction($1, preferred: preferred, enabled: enabled, image: nil, handler: handler, style: .default) }
    }
    
    public func destructive(_ title: String, preferred: Bool = false, enabled: Bool = true, image: UIImage? = nil, handler: ActionHandler?) -> Self {
        return addAction(title, preferred: preferred, enabled: enabled, image: image, handler: handler, style: .destructive)
    }
    
    public func cancel(_ title: String, preferred: Bool = false, enabled: Bool = true, image: UIImage? = nil, handler: ActionHandler? = nil) -> Self {
        return addAction(title, preferred: preferred, enabled: enabled, image: image, handler: handler, style: .cancel)
    }
    
    public func create() -> AlertController {
        return AlertController(configuration: configuration)
    }
    
    public func show() -> AlertController {
        let controller = create()
        controller.show()
        return controller
    }
    
    func style(_ style: UIAlertControllerStyle) -> Self {
        return modify { (config: inout AlertControllerConfiguration) in config.style = style }
    }
    
    fileprivate func addAction(_ title: String, preferred: Bool, enabled: Bool, image: UIImage?, handler: ActionHandler?, style: UIAlertActionStyle) -> Self {
        return modify { (config: inout AlertControllerConfiguration) in
            let action = Action(style: style, enabled: enabled, image: image, handler: handler)
            config.actions.append((title, action))
            config.preferredAction = preferred ? title : config.preferredAction
        }
    }
    
    func modify(_ modify: (inout AlertControllerConfiguration) -> ()) -> Self {
        var copy = self
        modify(&copy.configuration)
        return copy
    }
    
}

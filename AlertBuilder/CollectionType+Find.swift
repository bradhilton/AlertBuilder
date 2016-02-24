//
//  CollectionType+Find.swift
//  AlertBuilder
//
//  Created by Bradley Hilton on 2/23/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension CollectionType {
    
    @warn_unused_result
    public func find(@noescape predicate: (Self.Generator.Element) throws -> Bool) rethrows -> Self.Generator.Element? {
        for element in self {
            guard try !predicate(element) else { return element }
        }
        return nil
    }
    
}

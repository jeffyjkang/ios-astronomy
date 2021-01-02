//
//  Cache.swift
//  Astronomy
//
//  Created by Jeff Kang on 1/1/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation


class Cache<Key: Hashable, Value> {
    private var imageCache: [Key : Value] = [:]
    
    private var queue = DispatchQueue(label: "cacheQueue")
    
    func cache(value: Value, forKey key: Key) {
        queue.async {
            self.imageCache[key] = value
        }
    }
    
    func value(forKey key: Key) -> Value? {
        queue.sync {
            imageCache[key]
        }
    }
}

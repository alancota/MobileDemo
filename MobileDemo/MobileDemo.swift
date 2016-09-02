//
//  MobileDemo.swift
//  MobileDemo
//
//  Created by Mike Moore on 8/23/16.
//  Copyright © 2016 Mike Moore. All rights reserved.
//

import Foundation

// Simple Helper for State
class MobileDemo {
    
    static let sharedInstance: MobileDemo = MobileDemo()
    
    private var status: MASState = .NotInitialized
    
    func getStatus() -> MASState {
        return status
    }
    
    func setStatus(state: MASState)
    {
        self.status = state
    }
    
}

// Nice String extension to simplify Base64 encode/decode
extension String {
    
    func base64Encoded() -> String {
        let plainData = dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return base64String!
    }
    
    func base64Decoded() -> String {
        if let decodedData = NSData(base64EncodedString: self, options:NSDataBase64DecodingOptions(rawValue: 0)) {
            let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding)
            return decodedString as! String
        } else {
            return self
        }
    }
}

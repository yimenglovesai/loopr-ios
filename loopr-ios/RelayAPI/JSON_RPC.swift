//
//  JSON_RPC.swift
//  loopr-ios
//
//  Created by Xiao Dou Dou on 2/4/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import Foundation
import SwiftyJSON

// https://github.com/Loopring/relay/blob/wallet_v2/LOOPRING_RELAY_API_SPEC_V2.md#loopring_getorders
class JSON_RPC {
    
    static let contractVersion = "v1.0"
    
    public static func getBalance(completionHandler: @escaping CompletionHandler) {
        var body: JSON = JSON()
        body["method"] = "loopring_getBalance"
        body["params"] = [["owner": "0x847983c3a34afa192cfee860698584c030f4c9db1"]]
        body["params"]["contractVersion"] = JSON(contractVersion)
        body["id"] = "1a715e2557abc0bd"
        
        Request.send(body: body) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            completionHandler(data, response, error)
        }
    }

    static func getOrders(completionHandler: @escaping CompletionHandler) {
        var body: JSON = JSON()
        body["method"] = "loopring_getOrders"
        body["params"] = [["ringHash": nil, "pageIndex": 0, "pageSize": 20]]
        body["params"]["contractVersion"] = JSON(contractVersion)
        body["id"] = "1a715e2557abc0bd"
        
        Request.send(body: body) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            completionHandler(data, response, error)
        }
    }

    static func getDepth(completionHandler: @escaping CompletionHandler) {
        var body: JSON = JSON()
        body["method"] = "loopring_getDepth"
        body["params"] = [["market": "LRC-WETH", "length": 0]]
        body["params"]["contractVersion"] = JSON(contractVersion)
        body["id"] = "1a715e2557abc0bd"
        
        Request.send(body: body) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            completionHandler(data, response, error)
        }
    }

    // FIXME: Get an error - "The method loopring_getTickers does not exist\/is not available"
    static func getTickers(completionHandler: @escaping CompletionHandler) {
        var body: JSON = JSON()
        body["method"] = "loopring_getTickers"
        body["params"]["contractVersion"] = JSON(contractVersion)
        body["id"] = "1a715e2557abc0bd"
        
        Request.send(body: body) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            completionHandler(data, response, error)
        }
    }
    
    static func getFills(market: String, owner: String, orderHash: String, ringHash: String, pageIndex: UInt, pageSize: UInt, completionHandler: @escaping CompletionHandler) {
        var body: JSON = JSON()
        body["method"] = "loopring_getFills"
        body["params"] = [["market": market]]
        
        // TODO: support other params
        /*
        body["params"]["contractVersion"] = JSON(contractVersion)
        body["params"]["owner"] = JSON(owner)
        body["params"]["orderHash"] = JSON(orderHash)
        body["params"]["ringHash"] = JSON(ringHash)
        body["params"]["pageIndex"] = JSON(pageIndex)
        body["params"]["pageSize"] = JSON(pageSize)
        */
        body["id"] = "1a715e2557abc0bd"
        
        Request.send(body: body) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            completionHandler(data, response, error)
        }
    }
    
    // FIXME:
    /*
    response = {
        "id" : "1a715e2557abc0bd",
        "error" : {
            "code" : -32602,
            "message" : "invalid argument 0: json: cannot unmarshal object into Go value of type string"
        },
        "jsonrpc" : "2.0"
    }
    */
    static func getTrend(market: String, interval: String, completionHandler: @escaping CompletionHandler) {
        var body: JSON = JSON()
        body["method"] = "loopring_getTrend"
        body["params"] = [["market": market, "interval": interval]]
        body["params"]["contractVersion"] = JSON(contractVersion)
        body["id"] = "1a715e2557abc0bd"
        
        Request.send(body: body) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            completionHandler(data, response, error)
        }
    }
    
    // TODO:
    static func getRingMined(completionHandler: @escaping CompletionHandler) {
        
    }
}

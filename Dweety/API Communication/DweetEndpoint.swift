//
//  DweetEndpoint.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Alamofire

enum DweetEndpoint {
    case getLatestDweetsFor(thing:String)
    case postDweetFor(thing:String)
    case listenDweetsFor(thing:String)
    
    var path : String {
        switch self {
            case .getLatestDweetsFor(let thing):
                return "https://dweet.io:443/get/dweets/for/".appending(thing)
            case .listenDweetsFor(let thing):
                return "https://dweet.io/listen/for/dweets/from/".appending(thing)
            case .postDweetFor(let thing):
                return "https://dweet.io/dweet/for/".appending(thing)
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .postDweetFor(thing: _):
            return .post
        default:
            return .get
        }
    }
    
    var parameters : [String:Any]? {
        switch self {
        case .postDweetFor(thing: _):
            return ["Dweeting":"Dweet"]
        default:
            return nil
        }
    }
    
}

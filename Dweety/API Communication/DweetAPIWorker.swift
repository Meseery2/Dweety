//
//  DweetAPIWorker.swift
//  Dweety
//
//  Created by Mohamed EL Meseery on 9/3/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import Alamofire

typealias dweetsOnSuccessCallback = ([DweetModel]?)->Void
typealias dweetsOnFailureCallback = (Error)->Void

struct DweetAPIWorker {
    public func getDweets(for thing:String,
                          ifSucceeded
        onSuccess:@escaping dweetsOnSuccessCallback,
                           ifFailed
        onFailure:@escaping dweetsOnFailureCallback)  {
        let path = DweetEndpoint.getLatestDweetsFor(thing: thing).path
        Alamofire.request(path).responseJSON { (response) in
            if let error = response.error {
                onFailure(error)
                return
            }
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let dweets = try decoder.decode(DweetResponseModel.self, from:data)
                    onSuccess(dweets.with)
                } catch {
                    print("error trying to convert data to JSON")
                    onFailure(error)
                }
            }else{
                onSuccess(nil)
            }
        }
    }
}

//
//  loader.swift
//  JsonUi
//
//  Created by Brian Cardarella on 3/19/21.
//

import Foundation
import SwiftPhoenixClient
import SwiftSoup
import Alamofire


let PHX_MAIN = "data-phx-main"
let PHX_SESSION = "data-phx-session"
let PHX_STATIC = "data-phx-static"
let PHX_VIEW = "data-phx-view"

class Loader {
    var socket: Socket
    var attrs: [String: String] = [:]
    
    init () {
        
        self.socket = Socket("ws://localhost:4000/live")
        print("*** Attempting to connect ***")
        socket.connect()
        
        socket.onOpen { print("Socket Opened") }
        socket.onClose { print("Socket Closed") }
        socket.onError { (error) in print("Socket Error", error) }
        
        let url = "http://localhost:4000"
        AF.request(url, headers: ["Content-Type": "application/swift; charset=utf-8"]).responseString { response in
            do {
                let doc = try SwiftSoup.parse(response.value!)
                let main = try doc.select("div[\(PHX_MAIN)=\"true\"]")
                self.attrs = [
                    "session": try main.attr(PHX_SESSION),
                    "static": try main.attr(PHX_STATIC),
                    "view": try main.attr(PHX_VIEW)
                ]
                print(self.attrs)
            }
            catch {
                
            }
            //        return try doc.text()
        }
    }
}

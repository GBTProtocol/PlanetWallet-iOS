//
//  Board.swift
//  PlanetWallet
//
//  Created by grabity on 24/06/2019.
//  Copyright © 2019 grabity. All rights reserved.
//

import Foundation
import ObjectMapper

class Board: Mappable {
    var id: Int?
    var subject: String?
    var created_at: String?
    var lang: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        subject <- map["subject"]
        created_at <- map ["created_at"]
        lang <- map ["lang"]
    }
}

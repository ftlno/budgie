//
//  Crypto.swift
//  Budgie
//
//  Created by Fredrik Lillejordet on 15.06.2017.
//  Copyright © 2017 Fredrik Lillejordet. All rights reserved.
//

import Foundation

struct Crypto: Codable {
    var id: String
    var name: String
    var symbol: String
    var rank: String?
    var price_usd: String?
    var price_btc: String?
    var market_cap_usd: String?
    var available_supply: String?
    var total_supply: String?
    var percent_change_1h: String?
    var percent_change_24h: String?
    var percent_change_7d: String?
    var last_updated: String?
}


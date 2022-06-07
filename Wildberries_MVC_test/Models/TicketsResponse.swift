//
//  Routes.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 05.06.2022.
//

import Foundation

struct TicketsResponse: Decodable {
    let meta: Meta
    let data: [Ticket]
}

struct Ticket: Decodable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
    var isLiked: Bool? = false

}
struct Meta: Decodable {
}





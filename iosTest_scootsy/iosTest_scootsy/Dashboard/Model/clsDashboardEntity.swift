//
//  clsDashboardEntity.swift
//  iosTest_scootsy
//
//  Created by vivek G on 14/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import Foundation

struct clsDashboardEntity: Decodable
{
    var id: String? = ""
    var name: String = ""
    var image : String = ""
    var count : Int = 0
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? "-1"
        name = json["name"] as? String ?? ""
        image = json["image"] as? String ?? ""
        count = json["count"] as? Int ?? -1
    }
}
struct clsVenderDetailsEntity: Decodable
{
    var id: String? = ""
    var name: String = ""
    var description: String = ""
    var image : String = ""
    var app_image : String = ""
    var locality_name : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var order_min_time : Int = 0
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? "-1"
        name = json["name"] as? String ?? ""
        description = json["description"] as? String ?? ""
        image = json["image"] as? String ?? ""
        app_image = json["app_image"] as? String ?? ""
        locality_name = json["locality_name"] as? String ?? ""
        latitude = json["latitude"] as? String ?? ""
        longitude = json["longitude"] as? String ?? ""
        order_min_time = json["order_min_time"] as? Int ?? -1
    }
}

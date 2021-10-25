//
//  HighSchool.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/23/21.
//

import Foundation

struct HighSchool: Decodable {
    let dbn: String
    let schoolName: String
    let overviewParagraph: String
    let phoneNumber: String
    let schoolEmail: String?
    let website: String
    let location: String
    let city: String
    let latitude: String?
    let longitude: String?
    var scores: HighSchoolScore?
    
    
    enum CodingKeys: String, CodingKey {
        case dbn, location, website, city, latitude, longitude
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case phoneNumber = "phone_number"
        case schoolEmail = "school_email"
    }
}

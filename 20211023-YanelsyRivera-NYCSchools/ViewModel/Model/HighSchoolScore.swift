//
//  HighSchoolScore.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import Foundation

struct HighSchoolScore: Decodable {
    let dbn: String
    let schoolName: String
    let criticalScore: String
    let mathScore: String
    let writingScore: String

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case criticalScore = "sat_critical_reading_avg_score"
        case mathScore = "sat_math_avg_score"
        case writingScore = "sat_writing_avg_score"
    }
}

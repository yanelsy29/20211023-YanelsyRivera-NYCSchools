//
//  HighSchoolTableViewCell.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit

class HighSchoolTableViewCell: UITableViewCell {
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    
    static let identifier = "highSchoolTableCell"
    
    override class func awakeFromNib() {
        
    }
    
    func setHighSchoolInfo(_ highSchool: HighSchool) {
        schoolNameLabel.text = highSchool.schoolName
        locationLabel.text = highSchool.location
        phoneNumberLabel.text = highSchool.phoneNumber
        emailLabel.text = highSchool.schoolEmail
        websiteLabel.text = highSchool.website
        
        shadowView.rounded()
    }
}

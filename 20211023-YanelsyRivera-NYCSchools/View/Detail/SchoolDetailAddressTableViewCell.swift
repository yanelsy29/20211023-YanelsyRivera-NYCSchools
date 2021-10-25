//
//  SchoolDetailAddressTableViewCell.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit
import MapKit

class SchoolDetailAddressTableViewCell: UITableViewCell {
   
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    var openMap: (() -> Void)!
    
    static let identifier = "addressCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.rounded()
    }
    
    func setSchoolInfo(_ school: HighSchool) {
        addressLabel.text = school.location + "\n" + (school.city ?? "")
     
    }
    
    @IBAction func openMapView() {
        openMap()
    }
    
}

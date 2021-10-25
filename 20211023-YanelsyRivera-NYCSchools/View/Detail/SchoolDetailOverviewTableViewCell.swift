//
//  SchoolDetailOverviewTableViewCell.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit

class SchoolDetailOverviewTableViewCell: UITableViewCell {
   
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    
    static let identifier = "overviewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.rounded()
    }
}

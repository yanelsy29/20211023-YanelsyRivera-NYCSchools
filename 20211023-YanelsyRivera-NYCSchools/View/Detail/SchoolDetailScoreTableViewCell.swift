//
//  SchoolDetailScoreTableViewCell.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit

class SchoolDetailScoreTableViewCell: UITableViewCell {
   
    @IBOutlet var criticalScoreLabel: UILabel!
    @IBOutlet var mathScoreLabel: UILabel!
    @IBOutlet var writingScore: UILabel!
    @IBOutlet var shadowView: UIView!
    
    static let identifier = "scoreCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.rounded()
    }
    
    func setScores(_ scores: HighSchoolScore) {
        criticalScoreLabel.text = "SAT Critical Reading Avg. Score: \(scores.criticalScore)"
        mathScoreLabel.text = "SAT Math Avg. Score: \(scores.mathScore)"
        writingScore.text = "SAT Reading Avg. Score: \(scores.writingScore)"
    }
}

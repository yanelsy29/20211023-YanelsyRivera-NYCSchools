//
//  SchoolDetailContactInfoTableViewCell.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit
import MessageUI

class SchoolDetailContactInfoTableViewCell: UITableViewCell {
   
    // MARK: - Properties
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    
    var sendMailAction: (() -> Void)!
    
    static let identifier = "contactInfoCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestures()
    }
    
    func setSchoolInfo(_ school: HighSchool) {
        schoolNameLabel.text = school.schoolName
        emailLabel.text = school.schoolEmail
        phoneLabel.text = school.phoneNumber
        websiteLabel.text = school.website
    }
    
    func addGestures() {
        let phoneTapGesture = UITapGestureRecognizer(target: self, action: #selector(call))
        self.phoneLabel.isUserInteractionEnabled = true
        self.phoneLabel.addGestureRecognizer(phoneTapGesture)
        
        let websiteTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToWebsite))
        self.websiteLabel.isUserInteractionEnabled = true
        self.websiteLabel.addGestureRecognizer(websiteTapGesture)
        
        let mailTapGesture = UITapGestureRecognizer(target: self, action: #selector(sendMail))
        self.emailLabel.isUserInteractionEnabled = true
        self.emailLabel.addGestureRecognizer(mailTapGesture)
    }
    
    @objc func call() {
        guard let url = phoneLabel.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url = URL(string: "tel://\(url)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func goToWebsite() {
        guard let string = websiteLabel.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if var url = URL(string: string) {
            let httpPrefix = "http://"
            
            if !string.contains(httpPrefix) {
                url = URL(string: httpPrefix + url.absoluteString)!
            }
            UIApplication.shared.open(url)
        }
    }
    
    @objc func sendMail() {
        sendMailAction()
    }
    
}

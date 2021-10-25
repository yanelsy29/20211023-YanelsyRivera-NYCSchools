//
//  HighSchoolDetailViewModel.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit

protocol HighSchoolDetailViewModelDelegate {
    func openMail()
    func openMapView()
}

class HighSchoolDetailViewModel {
    
    enum DetailRows: Int {
        case contactInfo
        case score
        case overview
        case address
    }
    
    // MARK: - Properties
    var school: HighSchool
    var delegate: HighSchoolDetailViewModelDelegate?
    
    // MARK: - Functions
    init(school: HighSchool) {
        self.school = school
    }
    
    // MARK: - Functions / Methods
    func registerCells(in tableView: UITableView) {
        tableView.register(UINib(nibName: "SchoolDetailContactInfoTableViewCell", bundle: nil), forCellReuseIdentifier: SchoolDetailContactInfoTableViewCell.identifier)
        tableView.register(UINib(nibName: "SchoolDetailAddressTableViewCell", bundle: nil), forCellReuseIdentifier: SchoolDetailAddressTableViewCell.identifier)
        tableView.register(UINib(nibName: "SchoolDetailOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: SchoolDetailOverviewTableViewCell.identifier)
        tableView.register(UINib(nibName: "SchoolDetailScoreTableViewCell", bundle: nil), forCellReuseIdentifier: SchoolDetailScoreTableViewCell.identifier)
        
    }
    
    func getNumberOfRows() -> Int {
        return 4
    }
    
    func getCellHeight(at indexPath: IndexPath) -> CGFloat {
        switch DetailRows(rawValue: indexPath.row) {
        case .contactInfo, .overview, .address:
            return UITableView.automaticDimension
        case .score:
            return school.scores == nil ? 0 : UITableView.automaticDimension
        case .none:
            return 0
        }
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch DetailRows(rawValue: indexPath.row) {
        case .contactInfo:
            return contactInfoCell(tableView: tableView, indexPath: indexPath)
        case .score:
            return scoreCell(tableView: tableView, indexPath: indexPath)
        case .overview:
            return overviewCell(tableView: tableView, indexPath: indexPath)
        case .address:
            return addressCell(tableView: tableView, indexPath: indexPath)
        case .none:
            return UITableViewCell()
        }
    }
    
    /// This function get the selected High School contact's information like email, phone number and website
    ///
    /// - Returns: UITableViewCell
    private func contactInfoCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailContactInfoTableViewCell.identifier, for: indexPath) as? SchoolDetailContactInfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setSchoolInfo(school)
        cell.sendMailAction = {
            self.delegate?.openMail()
        }
        return cell
    }
    
    /// This function get the selected High School SAT's scores
    ///
    /// - Returns: UITableViewCell
    private func scoreCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailScoreTableViewCell.identifier, for: indexPath) as? SchoolDetailScoreTableViewCell else {
            return UITableViewCell()
        }
        
        if let scores = school.scores {
            cell.setScores(scores)
        }
        
        return cell
    }
    
    /// This function get the selected High School overview's
    ///
    /// - Returns: UITableViewCell
    private func overviewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailOverviewTableViewCell.identifier, for: indexPath) as? SchoolDetailOverviewTableViewCell else {
            return UITableViewCell()
        }
        cell.overviewLabel.text = school.overviewParagraph
        
        return cell
    }
    
    /// This function get the selected High School location's information
    ///
    /// - Returns: UITableViewCell
    private func addressCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailAddressTableViewCell.identifier, for: indexPath) as? SchoolDetailAddressTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setSchoolInfo(school)
        cell.openMap = {
            self.delegate?.openMapView()
        }
        
        return cell
    }
    
}

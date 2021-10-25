//
//  HighSchoolsListViewModel.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/23/21.
//

import Foundation
import UIKit


protocol HighSchoolListViewModelDelegate {
    // Call when fetching high school list was succefull or search bar's text was change
    func reloadView()
    // Call when an error ocurred fetch high school list
    func showMessage(_ message: String)
}

class HighSchoolsListViewModel {
    
    // MARK: - Properties
    private var highSchools: [HighSchool] = [] {
        didSet {
            filterSchools = highSchools
        }
    }
    private var filterSchools: [HighSchool] = []
    private var scores: [HighSchoolScore] = []
    var delegate: HighSchoolListViewModelDelegate?
    
    // MARK: - Initializer
    init() {
        fetchSchoolList()
    }
    
    // MARK: - Functions / Methods
    private func fetchSchoolList() {
        let apiRequest = APIRequest()
        apiRequest.get(url: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") { (result: Result<[HighSchool], ResultServerError>) in
            switch result {
            case .failure(let error):
                self.delegate?.showMessage(error.errorDescription)
            case .success(let schools):
                self.highSchools = schools
                DispatchQueue.main.async {
                    self.delegate?.reloadView()
                }
                self.getScores()
            }
        }
    }
    
    private func getScores() {
        let apiRequest = APIRequest()
        apiRequest.get(url: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") { (result: Result<[HighSchoolScore], ResultServerError>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let schoolsScore):
                self.scores = schoolsScore
            }
        }
    }
    
    private func getScore(at dbn: String) -> HighSchoolScore? {
        return scores.filter{$0.dbn == dbn}.first
    }
    
    func registerCell(in tableView: UITableView) {
        tableView.register(UINib(nibName: "HighSchoolTableViewCell", bundle: nil), forCellReuseIdentifier: HighSchoolTableViewCell.identifier)
    }
    
    func searchSchool(text: String) {
        filterSchools = highSchools.filter{$0.schoolName.lowercased().contains(text.lowercased())}
        self.delegate?.reloadView()
    }
    
    func cleanSearch() {
        filterSchools = highSchools
        self.delegate?.reloadView()
    }
    
    func getNumbersOfRow() -> Int {
        return filterSchools.count
    }
    
    /// This function get the selected High School object without SAT scores
    ///
    /// - Returns: HighSchool
    func getObject(at indexPath: IndexPath) -> HighSchool {
        return filterSchools[indexPath.row]
    }
    
    func highSchoolCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HighSchoolTableViewCell.identifier, for: indexPath) as? HighSchoolTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setHighSchoolInfo(self.getObject(at: indexPath))
        return cell
    }
    
    /// This function get the selected High School object with SAT scores
    ///
    /// - Returns: HighSchool
    func getSchool(at indexPath: IndexPath) -> HighSchool {
        var school = getObject(at: indexPath)
        school.scores = getScore(at: school.dbn)
        
        return school
    }
}

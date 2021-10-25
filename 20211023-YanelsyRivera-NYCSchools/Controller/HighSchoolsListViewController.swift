//
//  HighSchoolsListViewController.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/23/21.
//

import UIKit

class HighSchoolsListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = HighSchoolsListViewModel()
    private let detailSegueIdentifier = "detailSegue"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewTopConstraint: NSLayoutConstraint!
  
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        viewModel.delegate = self
        viewModel.registerCell(in: tableView)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            let controller = segue.destination as! HighSchoolDetailViewController
            controller.viewModel = HighSchoolDetailViewModel(school: sender as! HighSchool)
        }
    }
    
    private func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchSchool(searchBar:)))
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func searchSchool(searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.tableViewTopConstraint.constant = self.tableViewTopConstraint.constant == 0 ? 56 : 0
            self.view.layoutSubviews()
        }
    }
}
// MARK: - UISearchBar Delegate
extension HighSchoolsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            viewModel.searchSchool(text: searchText)
        } else if searchText.isEmpty {
            viewModel.cleanSearch()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchText.count > 3 {
            viewModel.searchSchool(text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cleanSearch()
    }
    
}

// MARK: - UITableView Delegate
extension HighSchoolsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumbersOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.highSchoolCell(tableView: tableView, indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: detailSegueIdentifier, sender: viewModel.getSchool(at: indexPath))
    }
    
}

// MARK: - ViewModel Delegate
extension HighSchoolsListViewController: HighSchoolListViewModelDelegate {
    
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(dismissButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadView() {
        self.tableView.reloadData()
    }

}

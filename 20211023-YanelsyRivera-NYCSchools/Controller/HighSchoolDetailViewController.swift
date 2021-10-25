//
//  HighSchoolDetailViewController.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit
import MessageUI

class HighSchoolDetailViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel: HighSchoolDetailViewModel!
    private let mapSegueIdentifier = "mapSegue"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupBackButton()
        viewModel.registerCells(in: tableView)
        viewModel.delegate = self
    }
    
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mapSegueIdentifier {
            let controller = segue.destination as! HighSchoolMapViewController
            controller.school = viewModel.school
        }
    }
    
    func setupBackButton() {
        let backButton: UIBarButtonItem = .init(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewController Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getCellHeight(at: indexPath)
    }
    
}

extension HighSchoolDetailViewController: HighSchoolDetailViewModelDelegate {
    func openMapView() {
        self.performSegue(withIdentifier: mapSegueIdentifier, sender: viewModel.school)
    }
    
    func openMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([(viewModel.school.schoolEmail ?? "")])
            mail.setMessageBody("<p>Hi! </p>", isHTML: true)

            present(mail, animated: true)
        } else {
            
        }
    }
    
    
}

extension HighSchoolDetailViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

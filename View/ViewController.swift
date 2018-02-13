//
//  ViewController.swift
//  JPMC
//
//  Created by Kevin on 2/12/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var mainNavigationBar: UINavigationItem!
    @IBOutlet weak var launchYearTextField: UITextField!
    
    var launchFeed = LaunchViewModel()
    var startDateFilter: String?
    var endDateFilter: String?
    var launchYearFilter: String?
    
    // I am using MVVM model since it is more flexible then MVC if need to add to app.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLaunches()
    }
    
    func getLaunches() {
        // start API Call
        launchFeed.feedRequest(launchYearFilter, startDateFilter: startDateFilter, endDateFilter: endDateFilter) { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    // Show alert if no results are found
                    if self.launchFeed.launch.count == 0 {
                        self.noResultsAlert()
                    }
                }
            }
            else if error != nil {
                self.noConnectionAlert()
            }
        }
    }
    
    func noResultsAlert() {
        let alertController = UIAlertController.init(title: "No Results", message: "", preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func noConnectionAlert() {
        let alertController = UIAlertController.init(title: "Error", message: "No Internet connection. Please try again", preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LaunchCell
        cell.setupCell(launch: self.launchFeed.launch[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchFeed.launch.count
    }
    
    // MARK: - IB Actions
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        filterView.alpha = 1
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        filterView.alpha = 0
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func applyButtonPressed(_ sender: UIBarButtonItem) {
        // Need to clear feed when filters are applied
        launchFeed.clearFeed()
        getLaunches()
        filterView.alpha = 0
        launchYearTextField.resignFirstResponder()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func startDateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDateFilter = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func finalDateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDateFilter = dateFormatter.string(from: sender.date)
    }
    
    // TextField Functions
    @IBAction func launchYearFilterChanged(_ sender: UITextField) {
          launchYearFilter = sender.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Only accept numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == launchYearTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}


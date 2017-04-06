//
//  FilterTableViewController.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/4/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func applyFilterParameters(_ aFilterParameters: Dictionary<String, String>)
}

class FilterTableViewController: UITableViewController, OfferingDealDelegate {
    
    var distances: [Dictionary<String, String>] = []
    var sortBy: [Dictionary<String, String>] = []
    var categories: [Dictionary<String, String>] = []
    var sectionHeaders : Array<String>! = []
    
    var filterParameters: Dictionary<String, String> = [:]
    
    var isDistancesOpen: Bool!
    var isSortByOpen : Bool!
    var isCategoriesOpen: Bool!
    
    var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionHeaders = ["", "Distance", "Sort by", "Categories"]
        distances = FilterManager.getDistances()
        sortBy = FilterManager.getSortCriteria()
        categories = FilterManager.getCategories()
        
        isDistancesOpen = false
        isSortByOpen = false
        isCategoriesOpen = false
        
        tableView.register(UINib(nibName: "FilterTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FilterTableHeaderView")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            if isDistancesOpen == true {
                return distances.count
            }
            return 1
        }
        else if section == 2 {
            if isSortByOpen == true {
                return sortBy.count
            }
           return 1
        }
        else if section == 3 {
            if isCategoriesOpen == true {
                return categories.count
            }
            return 1
        }
        return 0
    }
    
    func getOfferingDealCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferingDealCell", for: indexPath) as! OfferingDealTableViewCell
        cell.delegate = self
        if filterParameters[DEAL_FILTER] != nil {
            cell.dealSwitch.setOn(true, animated: true)
        }
        else {
            cell.dealSwitch.setOn(false, animated: true)
        }
        return cell
    }
    
    func getDistanceCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell", for: indexPath) as! DistancesTableViewCell
        cell.distanceObject = distances[indexPath.row]
        if isDistancesOpen == false && indexPath.row == 0 {
            cell.selectionLabel.text = "▼"
            cell.selectionLabel.layer.borderWidth = 0
        }
        else {
            if let meterValue = filterParameters[DISTANCE_FILTER] {
                if cell.distanceObject["code"] == meterValue {
                    cell.selectionLabel.text = "✔︎"
                    cell.selectionLabel.layer.borderColor = UIColor.cyan.cgColor
                    cell.selectionLabel.textColor = UIColor.cyan
                }
            }
        }
        return cell
    }
    
    func getSortByCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortByCell", for: indexPath) as! SortByTableViewCell
        cell.sortByObject = sortBy[indexPath.row]
        if isSortByOpen == false && indexPath.row == 0 {
            cell.selectionLabel.text = "▼"
            cell.selectionLabel.layer.borderWidth = 0
        }
        else {
            if let meterValue = filterParameters[SORT_FILTER] {
                if cell.sortByObject["code"] == meterValue {
                    cell.selectionLabel.text = "✔︎"
                    cell.selectionLabel.layer.borderColor = UIColor.cyan.cgColor
                    cell.selectionLabel.textColor = UIColor.cyan
                }
            }
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        
            let cell = getOfferingDealCell(tableView, indexPath: indexPath)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = getDistanceCell(tableView, indexPath: indexPath)
            return cell
        }
        else {
            let cell = getSortByCell(tableView, indexPath: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
        else if indexPath.section == 1 {
            if isDistancesOpen == true {
                let dict_ = distances[indexPath.row]
                filterParameters[DISTANCE_FILTER] =  dict_["code"]
            }
            isDistancesOpen = !isDistancesOpen
            tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.automatic)
        }
        else {
            if isSortByOpen == true {
                let dict_ = sortBy[indexPath.row]
                filterParameters[SORT_FILTER] =  dict_["code"]
            }
            isSortByOpen = !isSortByOpen
            tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sectionHeaders[section] == "" {
            return super.tableView(tableView, titleForHeaderInSection: section)
        }
        else {
            return sectionHeaders[section]
        }
    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    
    @IBAction func onSearchClick(_ sender: Any) {
        delegate?.applyFilterParameters(filterParameters)
        dismiss(animated: true) {}
    }
    
    func isSwitchOn(flag : Bool) {
        if flag == true {
            filterParameters[DEAL_FILTER] = "yes"
        }
        else {
            filterParameters.removeValue(forKey: DEAL_FILTER)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 

}


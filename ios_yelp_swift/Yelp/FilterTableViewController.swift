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

class FilterTableViewController: UITableViewController, SwitchCellDelegate {
    
    var distances: [Dictionary<String, String>] = []
    var sortBy: [Dictionary<String, String>] = []
    var categories: [Dictionary<String, String>] = []
    var deals: [Dictionary<String, String>] = []
    var sectionHeaders : Array<String>! = []
    
    var isDistancesOpen: Bool!
    var isSortByOpen : Bool!
    var isCategoriesOpen: Bool!
    
    var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionHeaders = ["", "Distance", "Sort by", "Categories"]
        distances = FilterHelper.getDistances()
        sortBy = FilterHelper.getSortCriteria()
        categories = FilterHelper.getCategories()
        deals = FilterHelper.deals
        
        isDistancesOpen = false
        isSortByOpen = false
        isCategoriesOpen = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return deals.count
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
            return 5
        }
        return 0
    }
    
    func getOfferingDealCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchTableViewCell
        cell.delegate = self
        cell.filterParamType = DEAL_FILTER
        cell.myObject = deals[indexPath.row]
        if FilterHelper.filterParameters[DEAL_FILTER] != nil {
            cell.mySwitch.setOn(true, animated: true)
        }
        else {
            cell.mySwitch.setOn(false, animated: true)
        }
        return cell
    }
    
    func getCategoryCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchTableViewCell
        cell.delegate = self
        cell.filterParamType = CATEGORY_FILTER
        cell.myObject = categories[indexPath.row]
        let index_ = FilterHelper.getCategoryIndexInFilterParam(cell.myObject["code"]!)
        if index_ >= 0 {
            cell.mySwitch.setOn(true, animated: true)
        }
        else {
            cell.mySwitch.setOn(false, animated: true)
        }
        return cell
    }

    func getDistanceCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandCell", for: indexPath) as! ExpandTableViewCell
        cell.cellObject = distances[indexPath.row]
        if isDistancesOpen == false && indexPath.row == 0 {
            let obj_ = FilterHelper.getSelectedDistance()
            if obj_ != nil {
                cell.cellObject = obj_!
            }
            cell.selectionLabel.text = "▼"
            cell.selectionLabel.layer.borderWidth = 0
        }
        else {
            if let meterValue = FilterHelper.filterParameters[DISTANCE_FILTER] {
                if cell.cellObject["code"] == meterValue {
                    cell.selectionLabel.text = "✔︎"
                    cell.selectionLabel.layer.borderColor = UIColor.cyan.cgColor
                    cell.selectionLabel.textColor = UIColor.cyan
                }
            }
        }
        return cell
    }
    
    func getSortByCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandCell", for: indexPath) as! ExpandTableViewCell
        cell.cellObject = sortBy[indexPath.row]
        if isSortByOpen == false && indexPath.row == 0 {
            let obj_ = FilterHelper.getSelectedSortCriteria()
            if obj_ != nil {
                cell.cellObject = obj_!
            }
            cell.selectionLabel.text = "▼"
            cell.selectionLabel.layer.borderWidth = 0
        }
        else {
            if let meterValue = FilterHelper.filterParameters[SORT_FILTER] {
                if cell.cellObject["code"] == meterValue {
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
        else if indexPath.section == 2 {
            let cell = getSortByCell(tableView, indexPath: indexPath)
            return cell
        }
        else {
            let cell = getCategoryCell(tableView, indexPath: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 3 {
            return
        }
        else if indexPath.section == 1 {
            if isDistancesOpen == true {
                let dict_ = distances[indexPath.row]
                FilterHelper.filterParameters[DISTANCE_FILTER] =  dict_["code"]
            }
            isDistancesOpen = !isDistancesOpen
            tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.automatic)
        }
        else {
            if isSortByOpen == true {
                let dict_ = sortBy[indexPath.row]
                FilterHelper.filterParameters[SORT_FILTER] =  dict_["code"]
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 && isCategoriesOpen == false {
            var footerView : UIView?
            footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 55))
            footerView?.backgroundColor = UIColor.white
            
            let button_ = UIButton.init(type: UIButtonType.system)
            button_.setTitle("See All", for: UIControlState.normal)
            button_.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            button_.frame = CGRect(x: 10, y: 5, width: (footerView?.frame.size.width)! - 20, height: 45)
            button_.addTarget(self, action: #selector(onSeeAllClick(_:)), for: UIControlEvents.touchUpInside)
            footerView?.addSubview(button_)
            
            return footerView
        }
        return super.tableView(tableView, viewForFooterInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 && isCategoriesOpen == false {
            return 55
        }
        return super.tableView(tableView, heightForFooterInSection: section)
    }
    
    func onSeeAllClick(_ sender:UIButton!){
        isCategoriesOpen = true
        tableView.reloadSections(NSIndexSet(index: 3) as IndexSet, with: UITableViewRowAnimation.automatic)
    }
    
    // Cancel navigation bar button click
    @IBAction func onCancelClick(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    // search navigation bar button click
    @IBAction func onSearchClick(_ sender: Any) {
        delegate?.applyFilterParameters(FilterHelper.filterParameters)
        dismiss(animated: true) {}
    }
    
    // SwitchCellDelegate method
    func isSwitchOn(flag : Bool, object: Dictionary<String, String>,  filterParamType: String) {
        
        if filterParamType == DEAL_FILTER {
            addRemoveDealsFilter(flag: flag, object: object)
        }
        else {
            addRemoveCategoriesFilter(flag: flag, categoryObject: object)
        }
    }
    
    func addRemoveDealsFilter(flag : Bool, object: Dictionary<String, String>) {
        if flag == true {
            FilterHelper.filterParameters[DEAL_FILTER] = "true"
        }
        else {
            FilterHelper.filterParameters.removeValue(forKey: DEAL_FILTER)
        }
    }
    
    func addRemoveCategoriesFilter(flag : Bool, categoryObject: Dictionary<String, String>) {
        
        if flag == true {
            FilterHelper.addToFilterCategories(categoryObject["code"]!)
        }
        else {
            FilterHelper.removeFromFilterCategories(categoryObject["code"]!)
        }
    }

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 

}


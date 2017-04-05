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
    
    var filterParameters: Dictionary<String, String> = [:]
    
    var isDistancesOpen: Bool!
    
    var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distances = [["Auto" : "auto"], ["0.3 Mile" : "482"], ["1 Mile": "1609"], ["5 Miles" : "8046"], ["20 Miles" : "32186"]]
        isDistancesOpen = false
        
        tableView.register(UINib(nibName: "FilterTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FilterTableHeaderView")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if isDistancesOpen == true {
            return distances.count
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        
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
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell", for: indexPath) as! DistancesTableViewCell
            cell.distanceObject = distances[indexPath.row]
            if isDistancesOpen == false && indexPath.row == 0 {
                cell.selectionLabel.text = "▼"
                cell.selectionLabel.layer.borderWidth = 0
            }
            else {
                if let meterValue = filterParameters[DISTANCE_FILTER] {
                    if cell.meterValue == meterValue {
                        cell.selectionLabel.text = "✔︎"
                        cell.selectionLabel.layer.borderColor = UIColor.cyan.cgColor
                        cell.selectionLabel.textColor = UIColor.cyan
                    }
                }
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
        else {
            if isDistancesOpen == true {
                let meterValues_ = distances[indexPath.row].values
                filterParameters[DISTANCE_FILTER] = Array(meterValues_)[0]
            }
            isDistancesOpen = !isDistancesOpen
            tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return super.tableView(tableView, titleForHeaderInSection: section)
        }
        else {
            return "Distance"
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


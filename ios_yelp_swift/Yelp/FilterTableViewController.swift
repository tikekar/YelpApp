//
//  FilterTableViewController.swift
//  Yelp
//
//  Created by Gauri Tikekar on 4/4/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func applyFilterParameters(_ filterParameters: NSDictionary)
}

class FilterTableViewController: UITableViewController {
    
    var distances: [Dictionary<String, String>] = []
    
    var filterParameters: NSMutableDictionary = [:]
    
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
                if let meterValue = filterParameters.object(forKey: DISTANCE_FILTER) as? String {
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
                filterParameters.setValue(Array(meterValues_)[0], forKey: DISTANCE_FILTER)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


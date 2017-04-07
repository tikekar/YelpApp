//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import SVProgressHUD


class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterDelegate {
    
    var businesses: [Business]!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    
    var filterParameters: Dictionary<String, String> = [:]
    var currentOffset: Int! = 0
    let refreshControl = UIRefreshControl()
    
    // Error message to show when network call fails
    var errorMessage: String! = "No Businesses Found"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSearchBar()
        initializeTableView()
        
        loadRestaurants()
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
    }
    
    func initializeSearchBar() {
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.keyboardDismissMode =  UIScrollViewKeyboardDismissMode.onDrag
        
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    func loadRestaurants() {
        errorMessage = "No Businesses Found"
        // TODO: Directly use FilterHelper's filterParameters
        filterParameters[TERM_FILTER] = "Restaurants"
        if searchBar.text?.isEmpty == false {
            filterParameters[TERM_FILTER] = searchBar.text!
        }
        if currentOffset != 0 {
            filterParameters[OFFSET_PARAM] = "\(currentOffset!)"
        }
        else {
            filterParameters.removeValue(forKey: OFFSET_PARAM)
            if businesses != nil { self.businesses.removeAll() }
        }
        SVProgressHUD.show()
        Business.searchWithParameters(parameters: filterParameters, completion: { (businesses: [Business]?, error: Error?) -> Void in
            SVProgressHUD.dismiss()
            if error != nil {
                self.errorMessage = error?.localizedDescription
                self.tableView.reloadData()
            }
            else {
                self.appendBusinesses(businesses)
                self.tableView.reloadData()
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            }
        })
    }
    
    func appendBusinesses(_ aBusinesses: [Business]?) {
        if aBusinesses == nil || aBusinesses!.count == 0 {
            return
        }
        currentOffset = currentOffset + aBusinesses!.count
        if businesses == nil {
            businesses = aBusinesses
            return
        }
        for i in 0...aBusinesses!.count-1 {
            businesses.append((aBusinesses?[i])!)
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // When movie view is empty, then show the empty view.
        // It will show the error from the server call if that is the reason for the empty movie set.
        if(businesses == nil || businesses.count == 0) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            // label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = errorMessage
            label.numberOfLines = 0
            tableView.backgroundView = label
            return 0
        }
        else {
            return businesses.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "BusinessCell") as! BusinessTableViewCell
        let business = businesses[indexPath.row]
        cell.business = business
        if(indexPath.row == businesses.count - 1) {
            loadRestaurants()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        currentOffset = 0
        loadRestaurants()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        currentOffset = 0
        loadRestaurants()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadRestaurants()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentOffset = 0
        loadRestaurants()
        
    }
    
    // FilterDelegate method
    func applyFilterParameters(_ aFilterParameters: Dictionary<String, String>) {
        filterParameters = aFilterParameters
        currentOffset = 0
        loadRestaurants()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Show Filter View") {
            if let viewController = segue.destination as? UINavigationController {
                let filterVC_ = viewController.childViewControllers[0] as! FilterTableViewController
                filterVC_.delegate = self
                FilterHelper.filterParameters = filterParameters
            }
        }
        else if(segue.identifier == "Show Map View") {
            let destinationViewController = segue.destination as! BusinessMapViewController
            let cell = sender as! BusinessTableViewCell
            destinationViewController.business = cell.business
        }
    }
}

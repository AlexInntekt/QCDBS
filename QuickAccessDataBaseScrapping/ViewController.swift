//
//  ViewController.swift
//  QuickAccessDataBaseScrapping
//
//  Created by Manolescu Mihai Alexandru on 19/08/2017.
//  Copyright © 2017 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit
import Foundation

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController)
    {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet var tableView: UITableView!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredData = [String]()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
 
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
       
    }
    
    //this function hides the status bar upwards:
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredData.count
        }
        
        return allData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        
        
        let object: String
        if isFiltering() {
            object = filteredData[indexPath.row]
        } else {
            object = allData[indexPath.row]
        }
        
        cell.textLabel?.text = String(object)
        
        
        return cell
    }
    

    
    //when a cell is tapped, the information contained is transfered with segue. The specific object will be fetched by index, from an array ('allData' or 'filteredData') depending if the searching is active or not:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var data :String = ""
        
        if(isFiltering())
        {
           data = String(filteredData[indexPath.row])
        }
        else
        {
           data = String(allData[indexPath.row])
        }
        
        performSegue(withIdentifier: "showObjectDetails", sender: data)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showObjectDetails"
        {
           let nextVC = segue.destination as! displayDetails
           nextVC.objectDescription = sender as! String
        }
    }

    
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All")
    {
        filteredData = allData.filter({( data : String) -> Bool in
            return String(data).lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool
    {
        return searchController.isActive && !searchBarIsEmpty()
    }
     
    
    
}






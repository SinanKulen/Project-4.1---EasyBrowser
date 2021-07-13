//
//  TableViewController.swift
//  EasyBrowser (Project 4)
//
//  Created by Sinan Kulen on 8.07.2021.
//

import UIKit

class TableViewController: UITableViewController {

    var site = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        site = ["www.google.com","www.hackingwithswift.com","www.apple.com"]
        
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return site.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebSite", for: indexPath)

        cell.textLabel?.text = site[indexPath.row]

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewC") as? ViewController{
            vc.selectedWebsite = site[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }


}


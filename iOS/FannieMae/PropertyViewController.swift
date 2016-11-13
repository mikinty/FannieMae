//
//  PropertyViewController.swift
//  FannieMae
//
//  Created by Arunjot Singh on 11/12/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import Foundation
import UIKit

class PropertyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let classification: [String] = ["Plumbing", "Electricity", "Lawn", "Bathrooms", "Bedrooms", "Roof", "A/C Heating", "Windows"]
    var selectedValue: Property!
    var url = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "classificationCell", for: indexPath)
        cell.textLabel?.text = classification[indexPath.row]
        if(selectedValue.status[indexPath.row] == 1) {
            cell.accessoryType = .none
        } else if (selectedValue.status[indexPath.row] == 0) {
            cell.accessoryType = .checkmark
        } 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let indexPath = tableView.indexPathForSelectedRow;
        url = selectedValue.images[indexPath!.row]
        index = indexPath!.row
        
        self.performSegue(withIdentifier: "show", sender: self)
        tableView.deselectRow(at: indexPath!, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        if segue.identifier == "show" {
            let destination = segue.destination as? ClassificationViewController
            //            let cell = sender as UITableViewCell
            //            let selectedRow = tableView.indexPathForCell(cell)!.row
            destination!.url = url
            destination!.object = selectedValue
            destination!.index = index
        }
    }
    
    
}


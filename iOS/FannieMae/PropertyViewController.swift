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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
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
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "show", sender: self)
        
    }

    
   
    
    
}


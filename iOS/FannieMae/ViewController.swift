//
//  ViewController.swift
//  FannieMae
//
//  Created by Arunjot Singh on 11/11/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit
import Firebase

class Property {
    var id = ""
    var name = ""
    var address = ""
    var houseImage = ""
    var images = [String]()
    var status = [Int]()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var objectToPass = Property()
    var houses = [Property]()
    var url = ""
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHouses()
        
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
        return houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertyTableViewCell
        let property = houses[indexPath.row]
//        
        let url = "\(property.id)/\(property.houseImage)"
        let storageRef = FIRStorage.storage().reference(forURL: "gs://fanniemae-efcae.appspot.com/\(url)")
        
        storageRef.downloadURL { (URL, error) -> Void in
            
            if (error != nil) {
                print(error!)
            } else {
                if let data = NSData(contentsOf: URL!) {
                    let image = UIImage(data: data as Data)
                    cell.houseImage.image = image
                }
                
            }

        }

        cell.houseName.text = property.name
        cell.houseAddress.text = property.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!) as! PropertyTableViewCell

        objectToPass.id = houses[(indexPath!.row)].id
        objectToPass.name = currentCell.houseName.text!
        objectToPass.address = currentCell.houseAddress.text!
        objectToPass.images = houses[(indexPath!.row)].images
        objectToPass.status = houses[(indexPath!.row)].status

        self.performSegue(withIdentifier: "showView", sender: self)
        
        tableView.deselectRow(at: indexPath!, animated: true)


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showView" {
            let destination = segue.destination as? PropertyViewController

            destination!.selectedValue = objectToPass
        }
    }
   
    
    func getHouses() {
        
        let storageRef = FIRStorage.storage().reference(forURL: "gs://fanniemae-efcae.appspot.com/houses.json")
        
        storageRef.downloadURL { (URL, error) -> Void in
            if (error != nil) {
                // Handle any errors
            } else {
              
            
                if let JSONData = NSData(contentsOf: URL!) {
                    let json: NSDictionary
                    
                    do {
                        json = try JSONSerialization.jsonObject(with: JSONData as Data, options: .allowFragments) as! NSDictionary
                        let results = json["id"] as! [String]
                        
                        for result in results {
                            let house = Property()
                            house.id = result
                            self.houses.append(house)
                        }
                        
//                        for house in self.houses {
                        let results2 = json["housesContainer"] as! [AnyObject]
                        
                        var count = 0
                        for result in results2 {
                            if (count < results2.count) {
                                self.houses[count].name = result["name"] as! String
                                self.houses[count].address = result["address"] as! String
                                self.houses[count].houseImage = result["houseImg"] as! String
                                self.houses[count].images = result["imgs"] as! [String]
                                self.houses[count].status = result["status"] as! [Int]
                            }
                            count += 1
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        
                        print("error trying to convert data to JSON")
                    }
                }

            }
            
        }
    }
}


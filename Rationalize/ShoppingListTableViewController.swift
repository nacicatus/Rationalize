//
//  ShoppingListTableViewController.swift
//  Rationalize
//
//  Created by Yajnavalkya on 2020. 04. 02..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//

import UIKit

struct Item: Decodable {
    let restaurant: String
    let foodItems: [FoodItems]
}

struct FoodItems: Decodable {
    let foodName, foodType, protein, calories: String
}

class ShoppingListTableViewController: UITableViewController {

//    var calorieNeed: Int?
//    var tableArray = [String]()
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //parseJSON()
        
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "foods", withExtension: "json")!)
            items = try JSONDecoder().decode([Item].self, from: data)
            tableView.reloadData()
        } catch { print(error)}
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].restaurant
        //cell.detailTextLabel?.text = items[indexPath.row].foodItems[0]
        return cell
    }
    
    
//    func parseJSON() {
//        let url = URL(string: "https://www.fsis.usda.gov/shared/data/EN/foodkeeper.json")
//        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//            guard error == nil else {
//                print("returned error")
//                return
//            }
//            
//            guard let content = data else {
//                print("No data")
//                return
//            }
//            
//            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String:Any] else {
//                print("Not containing JSON")
//                return
//            }
//            
//            if let array = json["Category_Name"] as? [String] {
//                self.tableArray = array
//            }
//            
//            print(self.tableArray)
//            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        
//        task.resume()
//    }


}


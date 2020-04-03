//
//  DashboardViewController.swift
//  Rationalize
//
//  Created by Yajnavalkya on 2020. 04. 02..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

    }
    
    
    @IBOutlet weak var peopleSlider: UISlider!
    @IBOutlet weak var familySize: UILabel!
    
    @IBOutlet weak var daySlider: UISlider!
    @IBOutlet weak var lockdownDays: UILabel!
    
    
    @IBOutlet weak var totalNeedLabel: UILabel!

    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var fatsLabel: UILabel!
    
    @IBOutlet weak var toiletPaperLabel: UILabel!
    
    @IBAction func peopleChanged(_ sender: Any?) {
        let famsize = peopleSlider.value
        //let dayNumbers = daySlider.value
        familySize.text = "\(Int(famsize))"
        
        updateNeeds()

    }
    
    @IBAction func daysChanged(_ sender: UISlider) {
        let dayNumbers = daySlider.value
        //let famsize = peopleSlider.value
        lockdownDays.text = "\(Int(dayNumbers))"
        
        updateNeeds()
        
    }
    
    
    func updateNeeds() {
        let dayNumbers = daySlider.value
        let famsize = peopleSlider.value
        let totalCalories = famsize * dayNumbers * 2000
        totalNeedLabel.text = "\(Int(totalCalories))"
        carbsLabel.text = "\(Int(0.5 * totalCalories))"
        proteinLabel.text = "\(Int(0.3 * totalCalories))"
        fatsLabel.text = "\(Int(0.2 * totalCalories))"
        toiletPaperLabel.text = String(format: "%.2f", (0.27 * famsize * dayNumbers))
    }
    
    @IBAction func addFamilyDetails(_ sender: UIButton) {
       performSegue(withIdentifier: "family", sender: self)
        
    }
    
    @IBAction func goShopping(_ sender: UIButton) {
        performSegue(withIdentifier: "shop", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
//        if (segue.identifier == "family") {
//            let familyMembers = segue.destination as! HouseholdTableViewController
//            familyMembers.members = Int(peopleSlider.value)
//        }
    }

}

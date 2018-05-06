//
//  ViewController.swift
//  SABR
//
//  Created by Juan Chavez on 4/16/18.
//  Copyright © 2018 Juan Chavez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedData : DataModel = DataModel()
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var OutfieldText: UITextView!
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var Year: UITextField!
    
    let RCLA13: Double = 14.239
    let RCLA14: Double = 13.5131
    let RCLA15: Double = 13.7069
    let RCLA16: Double = 14.4487
    let RCLA17: Double = 17.4335
    
    let RPLA13: Double = 102.4355
    let RPLA14: Double = 101.5140
    let RPLA15: Double = 94.3442
    let RPLA16: Double = 93.9130
    let RPLA17: Double = 110.1275
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //for input text
        FirstName.delegate = self
        FirstName.tag = 0
        LastName.delegate = self
        LastName.tag = 1
        Year.delegate = self
        Year.tag = 2
        
        //set delegates and initialize homeModel
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   /* @IBAction func SWAR(_ sender: Any) {
        let First: String = FirstName.text!
        let Last: String = LastName.text!
        let Season: String = Year.text!
        
        if ((FirstName.text?.isEmpty)! || (LastName.text?.isEmpty)! || (Year.text?.isEmpty)!){
            OutfieldText.text = "Please enter valid text into the text fields. Search not processed."
        }
        else {
            //OutfieldText.text = "This is the year you entered: \(Year.text!)"
            
            let homeModel = HomeModel()
            homeModel.delegate = self
            homeModel.downloadItemsWithWAR(firstName: First, lastName: Last, seasonYear: Season)
            
            if (Year.text == "2013"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA13) \n\nRuns Prevented League Average: \(RPLA13) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance."
            }
            else if (Year.text == "2014"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA14) \n\nRuns Prevented League Average: \(RPLA14) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance."
            }
            else if (Year.text == "2015"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA15) \n\nRuns Prevented League Average: \(RPLA15) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance."
            }
            else if (Year.text == "2016"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA16) \n\nRuns Prevented League Average: \(RPLA16) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance."
            }
            else if (Year.text == "2017"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA17) \n\nRuns Prevented League Average: \(RPLA17) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance."
            }
            else if (Year.text != "2013" || Year.text != "2014" || Year.text != "2015" || Year.text != "2016" || Year.text != "2017"){
                OutfieldText.text = "Please enter a valid year"
            }
        }
    }*/
    @IBAction func Search(_ sender: Any) {

        let First: String = FirstName.text!
        let Last: String = LastName.text!
        let Season: String = Year.text!

        if ((FirstName.text?.isEmpty)! || (LastName.text?.isEmpty)! || (Year.text?.isEmpty)!){
                OutfieldText.text = "Please enter valid text into the text fields. Search not processed."
        }
        else {
            let homeModel = HomeModel()
            homeModel.delegate = self
            homeModel.downloadItems(firstName: First, lastName: Last, seasonYear: Season)
            
            if (Year.text == "2013"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA13) \n\nRuns Prevented League Average: \(RPLA13) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance. \n\nFormulas: \n\nTB (Total Bases) = (Singles (Hits)) + (Doubles) + (Triples x 2) + (Home Runs x 3)\n\nRC (Runs Created) = ((Total Bases (TB) * (Hits (H) + Walks (BB) + Hits by Pitch (HBP) – Caught Stealing (CS) – Grounded into Double Plays (GiDP))) / (At-Bats (AB) + Walks (BB)))\n\nRP (Runs Prevented) = ((Putouts (PO) + Assists(A)) – Errors(E))\n\nRCPPS (Runs Created/Prevented Per Season) = RC / RP"

            }
            else if (Year.text == "2014"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA14) \n\nRuns Prevented League Average: \(RPLA14) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance. \n\nFormulas: \n\nTB (Total Bases) = (Singles (Hits)) + (Doubles) + (Triples x 2) + (Home Runs x 3)\n\nRC (Runs Created) = ((Total Bases (TB) * (Hits (H) + Walks (BB) + Hits by Pitch (HBP) – Caught Stealing (CS) – Grounded into Double Plays (GiDP))) / (At-Bats (AB) + Walks (BB)))\n\nRP (Runs Prevented) = ((Putouts (PO) + Assists(A)) – Errors(E))\n\nRCPPS (Runs Created/Prevented Per Season) = RC / RP"
            }
            else if (Year.text == "2015"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA15) \n\nRuns Prevented League Average: \(RPLA15) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance. \n\nFormulas: \n\nTB (Total Bases) = (Singles (Hits)) + (Doubles) + (Triples x 2) + (Home Runs x 3)\n\nRC (Runs Created) = ((Total Bases (TB) * (Hits (H) + Walks (BB) + Hits by Pitch (HBP) – Caught Stealing (CS) – Grounded into Double Plays (GiDP))) / (At-Bats (AB) + Walks (BB)))\n\nRP (Runs Prevented) = ((Putouts (PO) + Assists(A)) – Errors(E))\n\nRCPPS (Runs Created/Prevented Per Season) = RC / RP"
            }
            else if (Year.text == "2016"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA16) \n\nRuns Prevented League Average: \(RPLA16) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance. \n\nFormulas: \n\nTB (Total Bases) = (Singles (Hits)) + (Doubles) + (Triples x 2) + (Home Runs x 3)\n\nRC (Runs Created) = ((Total Bases (TB) * (Hits (H) + Walks (BB) + Hits by Pitch (HBP) – Caught Stealing (CS) – Grounded into Double Plays (GiDP))) / (At-Bats (AB) + Walks (BB)))\n\nRP (Runs Prevented) = ((Putouts (PO) + Assists(A)) – Errors(E))\n\nRCPPS (Runs Created/Prevented Per Season) = RC / RP"
            }
            else if (Year.text == "2017"){
                OutfieldText.text = "SCROLL THROUGH! \n\nRuns Created League Average: \(RCLA17) \n\nRuns Prevented League Average: \(RPLA17) \n\nAn RCPPS score of 'N/A' indicates that the player neither scored nor prevented any runs during the season. \n\nA RCPPS score of 1 indicates equality in offensive and defensive performance during the season. \n\nA score < 1 indicates stronger defensive performance. \n\nA score > 1 indicates stronger offensive performance. \n\nFormulas: \n\nTB (Total Bases) = (Singles (Hits)) + (Doubles) + (Triples x 2) + (Home Runs x 3)\n\nRC (Runs Created) = ((Total Bases (TB) * (Hits (H) + Walks (BB) + Hits by Pitch (HBP) – Caught Stealing (CS) – Grounded into Double Plays (GiDP))) / (At-Bats (AB) + Walks (BB)))\n\nRP (Runs Prevented) = ((Putouts (PO) + Assists(A)) – Errors(E))\n\nRCPPS (Runs Created/Prevented Per Season) = RC / RP"
            }
            else if (Year.text != "2013" || Year.text != "2014" || Year.text != "2015" || Year.text != "2016" || Year.text != "2017"){
                OutfieldText.text = "Please enter a valid year"
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        FirstName.resignFirstResponder()
        LastName.resignFirstResponder()
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: DataModel = feedItems[indexPath.row] as! DataModel
        // Get references to labels of cell
        if (item.RCPPS == "Null") {
            myCell.textLabel?.textAlignment = .center
            myCell.textLabel!.text = FirstName.text! + " " + LastName.text!
            myCell.detailTextLabel!.text = "RCPPS = N/A. Read Description Above"
            return myCell
        }
        else{
            if(item.BWAR == "3.1415926536" && item.BWAR == "3.1415926536"){
                myCell.textLabel?.textAlignment = .center
                myCell.textLabel!.text = item.firstname! + " " + item.lastname! + " Team: " + item.team!
                myCell.detailTextLabel!.text = "RCPPS= \(item.RCPPS!) \nRC = \(item.RC!) \nRP = \(item.RP!)"
                return myCell
            }
            else if(item.BWAR == "3.1415926536" && item.PWAR != "3.1415926536"){
                myCell.textLabel?.textAlignment = .center
                myCell.textLabel!.text = item.firstname! + " " + item.lastname! + " Team: " + item.team!
                myCell.detailTextLabel!.text = "RCPPS= \(item.RCPPS!) \nRC = \(item.RC!) \nRP = \(item.RP!) \nBatting War = N/A \nPitching War = \(item.PWAR!)"
                return myCell
            }
            else if(item.BWAR != "3.1415926536" && item.PWAR == "3.1415926536"){
                myCell.textLabel?.textAlignment = .center
                myCell.textLabel!.text = item.firstname! + " " + item.lastname! + " Team: " + item.team!
                myCell.detailTextLabel!.text = "RCPPS= \(item.RCPPS!) \nRC = \(item.RC!) \nRP = \(item.RP!) \nBatting War = \(item.BWAR!) \nPitching War = N/A"
                return myCell
            }
            else{
                myCell.textLabel?.textAlignment = .center
                myCell.textLabel!.text = item.firstname! + " " + item.lastname! + " Team: " + item.team!
                myCell.detailTextLabel!.text = "RCPPS= \(item.RCPPS!) \nRC = \(item.RC!) \nRP = \(item.RP!) \nBatting War = \(item.BWAR!) \nPitching War = \(item.PWAR!)"
                return myCell
            }
        }
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
        //textField.resignFirstResponder()
        //return true
    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

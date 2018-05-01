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
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var FirstName: UITextField!
    
    
    //use?
    @IBOutlet weak var Outputfield: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for input text
        LastName.delegate = self
        FirstName.delegate = self
        
        //set delegates and initialize homeModel
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Search(_ sender: Any) {

        let First: String = FirstName.text!
        let Last: String = LastName.text!

        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems(firstName: First, lastName: Last)
        
        //Outputfield.text = "You searched for: \(First)"
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
        myCell.textLabel!.text = item.firstname! + " " + item.lastname!
        //myCell.detailTextLabel!.text = "RCPPS= " + item.address! + "| RC = "
        return myCell
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

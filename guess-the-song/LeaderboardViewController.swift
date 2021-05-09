//
//  LeaderboardViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-11.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //creates a variable for alternating between the singleplayer and multiplayer tabs of the table view
    var selectedSegment = 0
    
    //creates an outlet for the table view
    @IBOutlet weak var tableView: UITableView!
    
    //creates an outlet for the segment control panel
    @IBOutlet weak var segmentPanel: UISegmentedControl!
    
    //creates a button action for the segment control panel
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        
        //reloads the data displayed every time a new segment is selected
        tableView.reloadData()
    }
    
    //creates an array for storing singleplayer scores (to be used with persistant data)
    var myArray: [String] = []
    
    //creates an array for storing multiplayer scores (to be used with persistant data)
    var myArray2: [String] = []
    
    //declares a variable with the number of rows for the table view
    var numberOfRows = 0
    
    //creates a function that returns the number of sections within the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //creates a function that alternates the number of rows present in the table views based on which segment of the segment control panel is currently pressed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentPanel.selectedSegmentIndex {
        case 0:
            numberOfRows = myArray.count
        case 1:
            numberOfRows = myArray2.count
        default:
            break
        }
        
        return numberOfRows
        
    }
    
    //creates a function that returns the name of the table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leaderboard"
    }
    
    //creates a function that alternates the information present in the cells in the table views based on which segment of the segment control panel is currently pressed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myReusedCell", for: indexPath)
        
        switch segmentPanel.selectedSegmentIndex {
        case 0:
            myCell.textLabel?.text = myArray[indexPath.row]
        case 1:
            myCell.textLabel?.text = myArray2[indexPath.row]
        default:
            break
        }
        
        return myCell
        
    }
    
    //creates a function that assigns the saved information using the key "save" to the myArray variable
    func loadData() {
        if let loadNames: [String] = UserDefaults.standard.value(forKey: "save") as? [String] {
            myArray = loadNames
        }
        
        //sorts the scores within myArray and reverses them to display the highest score at the top
        myArray = myArray.sorted()
        myArray = myArray.reversed()
    }
    
    //creates a function that assigns the saved information using the key "save2" to the myArray2 variable
    func loadData2() {
        if let loadNames2: [String] = UserDefaults.standard.value(forKey: "save2") as? [String] {
            myArray2 = loadNames2
        }
        
        //sorts the scores within myArray2 and reverses them to display the highest score at the top
        myArray2 = myArray2.sorted()
        myArray2 = myArray2.reversed()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loads the saved information (scores) when the app is launched
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadData()
        loadData2()
        
    }
    
    
}

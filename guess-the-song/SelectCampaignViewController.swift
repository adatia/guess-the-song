//
//  SelectCampaignViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-04.
//

import UIKit

class SelectCampaignViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //creates a button action for the drake campaign
    @IBAction func drakeSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the campaigns view controller to the drake titles and albums arrays
        currentTitles = drakeTitles
        currentAlbums = drakeAlbums
        currentAlbumCovers = drakeAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }

    //creates a button action for the future campaign
    @IBAction func futureSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the campaigns view controller to the future titles and albums arrays
        currentTitles = futureTitles
        currentAlbums = futureAlbums
        currentAlbumCovers = futureAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the nav campaign
    @IBAction func navSelect(_ sender: UIButton) {
        currentTitles = navTitles
        currentAlbums = navAlbums
        currentAlbumCovers = navAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the migos campaign
    @IBAction func migosSelect(_ sender: UIButton) {
        currentTitles = migosTitles
        currentAlbums = migosAlbums
        currentAlbumCovers = migosAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the rae sremmurd campaign
    @IBAction func sremmSelect(_ sender: UIButton) {
        currentTitles = sremmTitles
        currentAlbums = sremmAlbums
        currentAlbumCovers = sremmAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the justin bieber campaign
    @IBAction func bieberSelect(_ sender: UIButton) {
        currentTitles = bieberTitles
        currentAlbums = bieberAlbums
        currentAlbumCovers = bieberAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the rihanna campaign
    @IBAction func rihannaSelect(_ sender: UIButton) {
        currentTitles = rihannaTitles
        currentAlbums = rihannaAlbums
        currentAlbumCovers = rihannaAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the ariana grande campaign
    @IBAction func arianaSelect(_ sender: UIButton) {
        currentTitles = arianaTitles
        currentAlbums = arianaAlbums
        currentAlbumCovers = arianaAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the travis scott campaign
    @IBAction func travisSelect(_ sender: UIButton) {
        currentTitles = travisTitles
        currentAlbums = travisAlbums
        currentAlbumCovers = travisAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    //creates a button action for the weeknd campaign
    @IBAction func weekndSelect(_ sender: UIButton) {
        currentTitles = weekndTitles
        currentAlbums = weekndAlbums
        currentAlbumCovers = weekndAlbumCovers
        
        //performs a segue to the campaigns view controller
        performSegue(withIdentifier: "artistToGame", sender: nil)
    }
    
    
}

//
//  MultiplayerGenreSelectionViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-03.
//

import UIKit

class MultiplayerGenreSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //creates a button action for the rap/hip-hop button
    @IBAction func rapSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the multiplayer view controller and song guessing view controller to the rap titles, artists and albums arrays
        mSelectedGenreTitles = rapSongTitles
        mSelectedGenreArtists = rapSongArtists
        mSelectedGenreAlbums = rapSongAlbums
        mSelectedGenreAlbumCovers = rapSongAlbumCovers
        
        //performs a segue to the multiplayer view controller
        performSegue(withIdentifier: "multiplayerGenreToGame", sender: nil)
    }
    
    //creates a button action for the pop button
    @IBAction func popSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the multiplayer view controller and song guessing view controller to the pop titles, artists and albums arrays
        mSelectedGenreTitles = popSongTitles
        mSelectedGenreArtists = popSongArtists
        mSelectedGenreAlbums = popSongAlbums
        mSelectedGenreAlbumCovers = popSongAlbumCovers
        
        //performs a segue to the multiplayer view controller
        performSegue(withIdentifier: "multiplayerGenreToGame", sender: nil)
    }
    
    //creates a button action for the 70s button
    @IBAction func seventiesSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the multiplayer view controller and song guessing view controller to the 70s titles, artists and albums arrays
        mSelectedGenreTitles = seventiesSongTitles
        mSelectedGenreArtists = seventiesSongArtists
        mSelectedGenreAlbums = seventiesSongAlbums
        mSelectedGenreAlbumCovers = seventiesSongAlbumCovers
        
        //performs a segue to the multiplayer view controller
        performSegue(withIdentifier: "multiplayerGenreToGame", sender: nil)
    }

}

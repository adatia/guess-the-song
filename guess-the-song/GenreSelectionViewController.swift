//
//  GenreSelectionViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-01.
//

import UIKit

class GenreSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //creates a button action for the rap/hip-hop button
    @IBAction func rapSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the singleplayer view controller and song guessing view controller to the rap titles, artists and albums arrays
        selectedGenreTitles = rapSongTitles
        selectedGenreArtists = rapSongArtists
        selectedGenreAlbums = rapSongAlbums
        selectedGenreAlbumCovers = rapSongAlbumCovers
        
        //performs a segue to the singleplayer view contoller
        performSegue(withIdentifier: "genreToGame", sender: nil)
    }
    
    //creates a button action for the pop button
    @IBAction func popSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the singleplayer view controller and song guessing view controller to the pop titles, artists and albums arrays
        selectedGenreTitles = popSongTitles
        selectedGenreArtists = popSongArtists
        selectedGenreAlbums = popSongAlbums
        selectedGenreAlbumCovers = popSongAlbumCovers
        
        //performs a segue to the singleplayer view contoller
        performSegue(withIdentifier: "genreToGame", sender: nil)
    }
    
    //creates a button action for the 70s button
    @IBAction func seventiesSelect(_ sender: UIButton) {
        
        //sets all of the arrays used within the singleplayer view controller and song guessing view controller to the 70s titles, artists and albums arrays
        selectedGenreTitles = seventiesSongTitles
        selectedGenreArtists = seventiesSongArtists
        selectedGenreAlbums = seventiesSongAlbums
        selectedGenreAlbumCovers = seventiesSongAlbumCovers
        
        //performs a segue to the singleplayer view contoller
        performSegue(withIdentifier: "genreToGame", sender: nil)
    }
    
}

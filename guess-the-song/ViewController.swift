//
//  ViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-05-22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //creates the unwind segue to return to the main menu
    @IBAction func unwindToMainMenu(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    //creates a function that displays an alert box explaining the rules of singleplayer
    func howToPlaySinglplayer() {
        let alertController2 = UIAlertController(title: nil, message: "Singleplayer mode begins by having 9 random boxes appear. One box will have a hidden vinyl that the player must find. If the player flips a box and the box does not contain the vinyl, they have to guess a song and then continue searching for the crown. The game ends once the player runs out of lives or collects all 5 vinyls. If the player successfully obtains all 5 crowns, their accumulated score is doubled.", preferredStyle: .alert)
        
        alertController2.addAction(UIAlertAction(title: "Continue", style: .default))
        
        self.present(alertController2, animated: true, completion: nil)
    }
    
    //creates a function that displays an alert box explaining the rules of multiplayer
    func howToPlayMultiplayer() {
        let alertController3 = UIAlertController(title: nil, message: "The multiplayer mode shares all of the same rules as the singleplayer mode, with one extra element: a human opponent. Players alternate turns searching for the box with the vinyl, and this will be unaffected by whether a player gets an answer right or wrong. The game ends once a player obtains all five crowns, or when a player loses all of their lives. Upon ending, the victorious player’s score is doubled.", preferredStyle: .alert)
        
        alertController3.addAction(UIAlertAction(title: "Continue", style: .default))
        
        self.present(alertController3, animated: true, completion: nil)
    }
    
    //creates a function that displays an alert box explaining the genres within the game
    func howToPlayGenres() {
        let alertController4 = UIAlertController(title: nil, message: "There are 3 specific genres with a multitude of songs available in Guess The Song: Rap/Hip-Hop, Pop, and 70s.", preferredStyle: .alert)
        
        alertController4.addAction(UIAlertAction(title: "Continue", style: .default))
        
        self.present(alertController4, animated: true, completion: nil)
    }
    
    //creates a function that displays an alert box explaining the rules of campaigns
    func howToPlayCampaigns() {
        let alertController5 = UIAlertController(title: nil, message: "Campaigns is a mode specially designed for players who would like to exercise their knowledge of one particular artist’s music. There are 10 different campaigns, each of which based around a different artist, and each containing 10 songs by or featuring that artist. There is no penality for guessing a song incorrectly.", preferredStyle: .alert)
        
        alertController5.addAction(UIAlertAction(title: "Continue", style: .default))
        
        self.present(alertController5, animated: true, completion: nil)
    }
    
    //creates a function that displays an alert box explaining how guessing songs works
    func howToPlayGuessingSongs() {
        let alertController6 = UIAlertController(title: nil, message: "The song guessing works as follows: a random song begins to play as a 45 second timer counts down in the background. Within this time, the player must guess the title of the song, the current artist singing, as well as the name of the album it belongs to. If the song is a single, re-enter the name of the song for the album title. The faster the answer, the more points a player gets. If a player guesses incorrectly, they lose a life, and players have 6 lives. However, they also have the option to give up when they don't know the answer to a category and they will not be penalized for not answering that category. ", preferredStyle: .alert)
        
        alertController6.addAction(UIAlertAction(title: "Continue", style: .default))
        
        self.present(alertController6, animated: true, completion: nil)
    }
    
    //creates a button action that displays an alert box with an options for which rules the user would like to see
    @IBAction func howToPlay(_ sender: UIButton) {
        let alertController = UIAlertController(title: "How To Play", message:
            "Welcome to Guess The Song! Below are explanations on how to play each of the 3 distinct modes available, as well as information on the available genres.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Guessing Songs", style: .default, handler: { action in
            
            self.howToPlayGuessingSongs()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Genres", style: .default, handler: { action in
            
            self.howToPlayGenres()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Singleplayer", style: .default, handler: { action in
            
            self.howToPlaySinglplayer()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Multiplayer", style: .default, handler: { action in
            
            self.howToPlayMultiplayer()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Campaigns", style: .default, handler: { action in
            
            self.howToPlayCampaigns()
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}


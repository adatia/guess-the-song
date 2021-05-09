//
//  EasterEggViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-05.
//

import UIKit
import AVFoundation

class EasterEggViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        scoreLabel.text = "Score: \(playerScore)"
        
        currentSong = Int.random(in: 0...ourSongs.count-1)
        
        currentTitle = ourSongs[currentSong]
        
        currentArtist = ourNames[currentSong]
        
        startup()
        
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var artistTextBox: UITextField!
    
    @IBOutlet weak var artistAnswer: UIImageView!
    
    @IBOutlet weak var okArtistButton: UIButton!
    
    @IBOutlet weak var giveUpButton: UIButton!
    @IBOutlet weak var nextSongButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    
    var currentSong = 0
    var currentTitle = ""
    var currentArtist = ""
    
    var userTitle = ""
    var userArtist = ""
    
    var correctArtists = 0
    
    var currentScore = 0
    var totalScore = 0
    
    var ourSongs: [String] = ["Shayn-01", "Shayn-02", "Shayn-03"]
    var ourNames: [String] = ["Shayn", "Shayn", "Shayn"]
    
    @IBAction func giveUp(_ sender: UIButton) {
        
        okArtistButton.isUserInteractionEnabled = false
        artistTextBox.isUserInteractionEnabled = false
        
        let alertController = UIAlertController(title: "Good effort!", message:
            "Nice try, maybe you'll get the next one.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
            
            self.totalScore += self.currentScore
            self.currentScore = 0
            self.ourSongs.remove(at: self.currentSong)
            self.ourNames.remove(at: self.currentSong)
            self.winCheck()
            self.scoreLabel.text = "Score: \(self.totalScore)"
            self.giveUpButton.isUserInteractionEnabled = false
            self.nextSongButton.isUserInteractionEnabled = true
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func winCheck() {
        if ourSongs.isEmpty {
            totalScore *= 2
            
            let alertController = UIAlertController(title: "Game finished!", message:
                "You finished the game! You guessed \(correctArtists) artists correctly. Your total score was doubled for finishing the game and your final score is now \(totalScore)", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Return to main menu", style: .default, handler: { action in
                
                self.performSegue(withIdentifier: "resetToMainMenu", sender: nil)
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func playSound(song: String) {
        
        do {
            if let fileURL = Bundle.main.path(forResource: song, ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
            
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        audioPlayer?.play()
    }
    
    func startup() {
        let alert = UIAlertController(title: "Press ok when you are ready to guess the song!", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            self.playSound(song: self.currentTitle)
            
        }))
        
        self.present(alert, animated: true)
    }
    
    func doubleCheck() {
        
        if okArtistButton.isUserInteractionEnabled == false {
            
            audioPlayer?.stop()
            
            if artistAnswer.image == #imageLiteral(resourceName: "XMark") {
                
                let alertController = UIAlertController(title: "Better luck next round!", message:
                    "Nice try, maybe you'll get the next one.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    self.totalScore += self.currentScore
                    self.currentScore = 0
                    self.ourSongs.remove(at: self.currentSong)
                    self.ourNames.remove(at: self.currentSong)
                    self.winCheck()
                    self.scoreLabel.text = "Score: \(self.totalScore)"
                    self.giveUpButton.isUserInteractionEnabled = false
                    self.nextSongButton.isUserInteractionEnabled = true
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Well done!", message:
                    "You guessed correctly and obtained 5 points!", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    self.totalScore += self.currentScore
                    self.currentScore = 0
                    self.ourSongs.remove(at: self.currentSong)
                    self.ourNames.remove(at: self.currentSong)
                    self.winCheck()
                    self.scoreLabel.text = "Score: \(self.totalScore)"
                    self.giveUpButton.isUserInteractionEnabled = false
                    self.nextSongButton.isUserInteractionEnabled = true
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func okArtist(_ sender: UIButton) {
        okArtistButton.isUserInteractionEnabled = false
        artistTextBox.isUserInteractionEnabled = false
        
        userArtist = artistTextBox.text!
        
        if userArtist == currentArtist {
            artistAnswer.image = #imageLiteral(resourceName: "CheckMark.png")
            artistAnswer.isHidden = false
            correctArtists += 1
        } else {
            artistAnswer.image = #imageLiteral(resourceName: "XMark")
            artistAnswer.isHidden = false
            playerLives -= 1
        }
        
        doubleCheck()
        
    }
    
    @IBAction func nextSong(_ sender: UIButton) {
        
        artistAnswer.image = nil
        
        currentSong = Int.random(in: 0...ourSongs.count-1)
        currentTitle = ourSongs[currentSong]
        currentArtist = ourNames[currentSong]
        
        okArtistButton.isUserInteractionEnabled = true
        artistTextBox.isUserInteractionEnabled = true
        
        artistTextBox.text?.removeAll()
        
        self.giveUpButton.isUserInteractionEnabled = true
        self.nextSongButton.isUserInteractionEnabled = false
        
        startup()
    }
    
}


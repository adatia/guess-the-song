//
//  MultiplayerSongGuessingViewController.swift
//  Adatia_Shayn_ISP
//
//  Created by Period Two on 2019-06-03.
//  Copyright © 2019 Period Two. All rights reserved.
//

import UIKit
import AVFoundation

class MultiplayerSongGuessingViewController: UIViewController, UITextFieldDelegate {
    
    //creates outlets for the title, artist and album text boxes
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var artistTextBox: UITextField!
    @IBOutlet weak var albumTextBox: UITextField!
    
    //creates an outlet for the timer
    @IBOutlet weak var timeLabel: UILabel!
    
    //creates outlets for the title, artist and album answer indicators
    @IBOutlet weak var titleAnswer: UIImageView!
    @IBOutlet weak var artistAnswer: UIImageView!
    @IBOutlet weak var albumAnswer: UIImageView!
    
    //creates outlets for the title, artist and album "ok "buttons
    @IBOutlet weak var okTitleButton: UIButton!
    @IBOutlet weak var okArtistButton: UIButton!
    @IBOutlet weak var okAlbumButton: UIButton!
    
    //creates an outlet for the album cover of the song that's currently playing
    @IBOutlet weak var albumCover: UIImageView!
    
    //creates a variable for an audio player
    var audioPlayer: AVAudioPlayer?
    
    //creates a variable to be used to generate a random number
    var currentSong = 0
    
    //creates variables for the current song's title, artist, album and album art
    var currentTitle = ""
    var currentArtist = ""
    var currentAlbum = ""
    var currentAlbumArt: UIImage = #imageLiteral(resourceName: "FUTURE.jpg")
    
    //creates variables to store the randomly selected song's title, artist and album
    var userTitle = ""
    var userArtist = ""
    var userAlbum = ""
    
    //creates variables to store the current amount of points obtained for each answer
    var titleCorrect = 0
    var artistCorrect = 0
    var albumCorrect = 0
    
    //creates a variable to store the total current score
    var currentScore = 0
    
    //creates variables for the timer and remaining time
    var timer:Timer?
    var timeLeft = 45
    
    //creates a variable used to store a message when the user obtains a vinyl
    var receivedVinyl = ""
    
    //creates a variable that keeps track of the amount of lives the user has lost this round
    var livesLost = 0
    
    //creates the button action for the give up button
    @IBAction func giveUp(_ sender: UIButton) {
        
        //performs the function that checks to see whether the user found a vinyl
        checkForVinyl()
        
        //stops the music and timer, and resets the timer
        audioPlayer?.stop()
        timer?.invalidate()
        timer = nil
        timeLeft = 45
        
        //creates an alert controller giving the user a summary of their results
        let alertController = UIAlertController(title: "Good effort!", message:
            "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Artist: \(artistCorrect) points, Album: \(albumCorrect) points. You lost \(livesLost) lives this game.\(receivedVinyl)", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
            
            if mPlayerTurn % 2 == 0 {
                mPlayer1Score += self.currentScore
                mPlayer1Lives -= self.livesLost
            } else if mPlayerTurn % 2 == 1 {
                mPlayer2Score += self.currentScore
                mPlayer2Lives -= self.livesLost
            }
            
            mPlayerTurn += 1
            
            self.performSegue(withIdentifier: "multiplayerBackToGame", sender: nil)
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func decreaseTimer()
    {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            
            checkForVinyl()
            
            audioPlayer?.stop()
            timer!.invalidate()
            timer = nil
            
            let alertController = UIAlertController(title: "Times up!", message:
                "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Artist: \(artistCorrect) points, Album: \(albumCorrect) points. You lost \(livesLost) lives this game.\(receivedVinyl)", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                if mPlayerTurn % 2 == 0 {
                    mPlayer1Score += self.currentScore
                    mPlayer1Lives -= self.livesLost
                } else if mPlayerTurn % 2 == 1 {
                    mPlayer2Score += self.currentScore
                    mPlayer2Lives -= self.livesLost
                }
                
                mPlayerTurn += 1
                
                self.performSegue(withIdentifier: "multiplayerBackToGame", sender: nil)
                
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
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.decreaseTimer), userInfo: nil, repeats: true)
            
        }))
        
        self.present(alert, animated: true)
    }
    
    func distributePoints() -> Int {
        switch timeLeft {
        case 41...45:
            currentScore += 8
            return 8
        case 36...40:
            currentScore += 7
            return 7
        case 31...35:
            currentScore += 6
            return 6
        case 26...30:
            currentScore += 5
            return 5
        case 21...25:
            currentScore += 4
            return 4
        case 16...20:
            currentScore += 3
            return 3
        case 11...15:
            currentScore += 2
            return 2
        case 1...10:
            currentScore += 1
            return 1
        default:
            return 0
        }
    }
    
    func tripleCheck() {
        
        if okTitleButton.isUserInteractionEnabled == false && okArtistButton.isUserInteractionEnabled == false && okAlbumButton.isUserInteractionEnabled == false {
            
            checkForVinyl()
            
            audioPlayer?.stop()
            timer?.invalidate()
            timer = nil
            timeLeft = 45
            
            if titleAnswer.image == #imageLiteral(resourceName: "XMark") && artistAnswer.image == #imageLiteral(resourceName: "XMark") && albumAnswer.image == #imageLiteral(resourceName: "XMark") {
                
                let alertController = UIAlertController(title: "Better luck next round!", message:
                    "Unfortunately, you got everything wrong. Every single thing. Shame on you. You lost not 1, not 2, but 3 lives this game. Go listen to some music and then keep playing.\(receivedVinyl)", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    if mPlayerTurn % 2 == 0 {
                        mPlayer1Lives -= self.livesLost
                    } else if mPlayerTurn % 2 == 1 {
                        mPlayer2Lives -= self.livesLost
                    }
                    
                    mPlayerTurn += 1
                    
                    self.performSegue(withIdentifier: "multiplayerBackToGame", sender: nil)
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Well done!", message:
                    "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Artist: \(artistCorrect) points, Album: \(albumCorrect) points. You lost \(livesLost) lives this game.\(receivedVinyl)", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    if mPlayerTurn % 2 == 0 {
                        mPlayer1Score += self.currentScore
                        mPlayer1Lives -= self.livesLost
                    } else if mPlayerTurn % 2 == 1 {
                        mPlayer2Score += self.currentScore
                        mPlayer2Lives -= self.livesLost
                    }
                    
                    mPlayerTurn += 1
                    
                    self.performSegue(withIdentifier: "multiplayerBackToGame", sender: nil)
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    func checkForVinyl() {
        if mVinylCrown == true {
            if titleAnswer.image == #imageLiteral(resourceName: "XMark") || artistAnswer.image == #imageLiteral(resourceName: "XMark") || albumAnswer.image == #imageLiteral(resourceName: "XMark") {
                receivedVinyl = " You got an answer wrong, so you didn't recieve a vinyl. Better luck next time!"
            } else if titleCorrect == 0 && artistCorrect == 0 && albumCorrect == 0 {
                receivedVinyl = " You didn't answer anything, so you didn't recieve a vinyl. Better luck next time!"
            } else if titleAnswer.image == #imageLiteral(resourceName: "CheckMark.png") || artistAnswer.image == #imageLiteral(resourceName: "CheckMark.png") || albumAnswer.image == #imageLiteral(resourceName: "CheckMark.png") {
                
                if mPlayerTurn % 2 == 0 {
                    mPlayer1Vinyls += 1
                } else if mPlayerTurn % 2 == 1 {
                    mPlayer2Vinyls += 1
                }
                
                receivedVinyl = " You also obtained a vinyl! Great job!"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if mFirstLoad == false {
            mFirstLoad = true
            mBackup1 = mSelectedGenreTitles
            mBackup2 = mSelectedGenreArtists
            mBackup3 = mSelectedGenreAlbums
            mBackup4 = mSelectedGenreAlbumCovers
        }
        
        currentSong = Int.random(in: 0...mSelectedGenreTitles.count-1)
        
        currentTitle = mSelectedGenreTitles[currentSong]
        
        currentArtist = mSelectedGenreArtists[currentSong]
        
        currentAlbum = mSelectedGenreAlbums[currentSong]
        
        currentAlbumArt = mSelectedGenreAlbumCovers[currentSong]
        
        UIView.transition(with: self.albumCover, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumCover.image = self.currentAlbumArt}, completion: nil)
        mSelectedGenreTitles.remove(at: currentSong)
        mSelectedGenreArtists.remove(at: currentSong)
        mSelectedGenreAlbums.remove(at: currentSong)
        mSelectedGenreAlbumCovers.remove(at: currentSong)
        
        if mSelectedGenreTitles.count == 0 {
            mSelectedGenreTitles = mBackup1
            mSelectedGenreArtists = mBackup2
            mSelectedGenreAlbums = mBackup3
            mSelectedGenreAlbumCovers = mBackup4
        }
        
        startup()
    }
    
    @IBAction func okTitle(_ sender: UIButton) {
        okTitleButton.isUserInteractionEnabled = false
        titleTextBox.isUserInteractionEnabled = false
        
        userTitle = (titleTextBox.text?.replacingOccurrences(of: " ", with: ""))!
        userTitle = (userTitle.replacingOccurrences(of: ".", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: "'", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: "’", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: ",", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: "/", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: "?", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: "-", with: ""))
        userTitle = (userTitle.replacingOccurrences(of: "&", with: "and"))
        userTitle = userTitle.uppercased()
        
        currentTitle = (currentTitle.replacingOccurrences(of: " ", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: ".", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: "'", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: "’", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: ",", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: "/", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: "?", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: "-", with: ""))
        currentTitle = (currentTitle.replacingOccurrences(of: "&", with: "and"))
        currentTitle = currentTitle.uppercased()
        
        if userTitle == currentTitle {
            titleAnswer.isHidden = false
            UIView.transition(with: self.titleAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.titleAnswer.image = #imageLiteral(resourceName: "CheckMark.png")}, completion: nil)
            titleCorrect = distributePoints()
        } else {
            titleAnswer.isHidden = false
            UIView.transition(with: self.titleAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.titleAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            livesLost += 1
            titleCorrect = 0
        }
        
        tripleCheck()
        
    }
    
    @IBAction func okArtist(_ sender: UIButton) {
        okArtistButton.isUserInteractionEnabled = false
        artistTextBox.isUserInteractionEnabled = false
        
        userArtist = (artistTextBox.text?.replacingOccurrences(of: " ", with: ""))!
        userArtist = (userArtist.replacingOccurrences(of: ".", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: "'", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: "’", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: ",", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: "/", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: "?", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: "-", with: ""))
        userArtist = (userArtist.replacingOccurrences(of: "&", with: "and"))
        userArtist = userArtist.uppercased()
        
        currentArtist = (currentArtist.replacingOccurrences(of: " ", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: ".", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: "'", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: "’", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: ",", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: "/", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: "?", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: "-", with: ""))
        currentArtist = (currentArtist.replacingOccurrences(of: "&", with: "and"))
        currentArtist = currentArtist.uppercased()
        
        if userArtist == currentArtist {
            artistAnswer.isHidden = false
            UIView.transition(with: self.artistAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.artistAnswer.image = #imageLiteral(resourceName: "CheckMark.png")}, completion: nil)
            artistCorrect = distributePoints()
        } else {
            artistAnswer.isHidden = false
            UIView.transition(with: self.artistAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.artistAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            livesLost += 1
            artistCorrect = 0
        }
        
        tripleCheck()
        
    }
    
    @IBAction func okAlbum(_ sender: UIButton) {
        okAlbumButton.isUserInteractionEnabled = false
        albumTextBox.isUserInteractionEnabled = false
        
        userAlbum = (albumTextBox.text?.replacingOccurrences(of: " ", with: ""))!
        userAlbum = (userAlbum.replacingOccurrences(of: ".", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: "'", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: "’", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: ",", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: "/", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: "?", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: "-", with: ""))
        userAlbum = (userAlbum.replacingOccurrences(of: "&", with: "and"))
        userAlbum = userAlbum.uppercased()
        
        currentAlbum = (currentAlbum.replacingOccurrences(of: " ", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: ".", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: "'", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: "’", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: ",", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: "/", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: "?", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: "-", with: ""))
        currentAlbum = (currentAlbum.replacingOccurrences(of: "&", with: "and"))
        currentAlbum = currentAlbum.uppercased()
        
        if userAlbum == currentAlbum {
            albumAnswer.isHidden = false
            UIView.transition(with: self.albumAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumAnswer.image = #imageLiteral(resourceName: "CheckMark.png")}, completion: nil)
            albumCorrect = distributePoints()
        } else {
            albumAnswer.isHidden = false
            UIView.transition(with: self.albumAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            livesLost += 1
            albumCorrect = 0
        }
        
        tripleCheck()
        
    }
    
}

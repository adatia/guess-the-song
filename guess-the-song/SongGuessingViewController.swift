//
//  SongGuessingViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-05-28.
//

import UIKit
import AVFoundation

class SongGuessingViewController: UIViewController, UITextFieldDelegate {

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
            
            //when the user presses continue, adds the score they accumulated from the current to their overall total score
            playerScore += self.currentScore
            
            //performs a segue back to the singleplayer view controller
            self.performSegue(withIdentifier: "backToGame", sender: nil)
                
        }))
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    //creates an objective-c function to decrement the timer
    @objc func decreaseTimer()
    {
        
        //decrements the time left variables and updates the timer label
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        
        //performs a check to see if the timer has reached 0
        if timeLeft <= 0 {
            
            
            //performs the function that checks to see whether a user found a vinyl
            checkForVinyl()
            
            //stops the music and timer
            audioPlayer?.stop()
            timer!.invalidate()
            timer = nil
            
            //creates an alert controller giving the user a summary of their results
            let alertController = UIAlertController(title: "Times up!", message:
                "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Artist: \(artistCorrect) points, Album: \(albumCorrect) points. You lost \(livesLost) lives this game.\(receivedVinyl)", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                //when the user presses continue, adds the score they accumulated from the current to their overall total score
                playerScore += self.currentScore
                
                //performs a segue back to the singleplayer view controller
                self.performSegue(withIdentifier: "backToGame", sender: nil)
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //creates a function that plays the specified song when it is called
    func playSound(song: String) {
        
        //finds the specified song's file location and sets the contents of the music player to that song; if it does not exist, prints an error message
        do {
            if let fileURL = Bundle.main.path(forResource: song, ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
            
        //if an error occurs, prints the error to the console
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
        //plays the music player
        audioPlayer?.play()
    }
    
    //creates a function that runs at the beginning of every song
    func startup() {
        
        //creates an alert controller that notifies the user to press ok when they are ready to play
        let alert = UIAlertController(title: "Press ok when you are ready to guess the song!", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            //begins the timer and begins playing the music
            self.playSound(song: self.currentTitle)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.decreaseTimer), userInfo: nil, repeats: true)
            
        }))
        
        self.present(alert, animated: true)
    }

    //creates a function that distributes a specific amount of points based on the amount of timer left on the timer
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
    
    //creates a function that runs once the user has answered everything
    func tripleCheck() {
        
        //checks to see if user interaction is disabled for every ok button
        if okTitleButton.isUserInteractionEnabled == false && okArtistButton.isUserInteractionEnabled == false && okAlbumButton.isUserInteractionEnabled == false {
            
            //performs the function that checks to see whether the user found a vinyl
            checkForVinyl()
            
            //stops the timer and music, and resets the timer
            audioPlayer?.stop()
            timer?.invalidate()
            timer = nil
            timeLeft = 45
            
            //if the user gets everything wrong, displays an alert box with an appropriate message :)
            if titleAnswer.image == #imageLiteral(resourceName: "XMark") && artistAnswer.image == #imageLiteral(resourceName: "XMark") && albumAnswer.image == #imageLiteral(resourceName: "XMark") {
                
                let alertController = UIAlertController(title: "Better luck next round!", message:
                    "Unfortunately, you got everything wrong. Every single thing. Shame on you. You lost not 1, not 2, but 3 lives this game. Go listen to some music and then keep playing.\(receivedVinyl)", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    //performs a segue back to the singleplayer view controller
                    self.performSegue(withIdentifier: "backToGame", sender: nil)
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
            //creates an alert controller giving the user a summary of their results
            let alertController = UIAlertController(title: "Well done!", message:
                "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Artist: \(artistCorrect) points, Album: \(albumCorrect) points. You lost \(livesLost) lives this game.\(receivedVinyl)", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
               
                //when the user presses continue, adds the score they accumulated from the current to their overall total score
                playerScore += self.currentScore
                
                //performs a segue back to the singleplayer view controller
                self.performSegue(withIdentifier: "backToGame", sender: nil)
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
            }
        }
    }
    
    //creates a function that checks to see if the user found a vinyl crown and answered correctly; if they did, they receive a vinyl
    func checkForVinyl() {
        if vinylCrown == true {
            if titleAnswer.image == #imageLiteral(resourceName: "XMark") || artistAnswer.image == #imageLiteral(resourceName: "XMark") || albumAnswer.image == #imageLiteral(resourceName: "XMark") {
                receivedVinyl = " You got an answer wrong, so you didn't recieve a vinyl. Better luck next time!"
            } else if titleCorrect == 0 && artistCorrect == 0 && albumCorrect == 0 {
                receivedVinyl = " You didn't answer anything, so you didn't recieve a vinyl. Better luck next time!"
            } else if titleAnswer.image == #imageLiteral(resourceName: "CheckMark.png") || artistAnswer.image == #imageLiteral(resourceName: "CheckMark.png") || albumAnswer.image == #imageLiteral(resourceName: "CheckMark.png") {
                vinyls += 1
                receivedVinyl = " You also obtained a vinyl! Great job!"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //allows the keyboard to be dismissed if the user taps anywhere on the screen that is not the keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //if this is the beginning of the game, creates backups of all of the currently used arrays
        if firstLoad == false {
            firstLoad = true
            backup1 = selectedGenreTitles
            backup2 = selectedGenreArtists
            backup3 = selectedGenreAlbums
            backup4 = selectedGenreAlbumCovers
        }
        
        //creates a random number that corresponds to a random song, and retrieves all of the information for that song
        currentSong = Int.random(in: 0...selectedGenreTitles.count-1)
        
        currentTitle = selectedGenreTitles[currentSong]
        
        currentArtist = selectedGenreArtists[currentSong]
        
        currentAlbum = selectedGenreAlbums[currentSong]
        
        currentAlbumArt = selectedGenreAlbumCovers[currentSong]
        
        //performs a transition to the current song's album cover
        UIView.transition(with: self.albumCover, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumCover.image = self.currentAlbumArt}, completion: nil)
        
        //removes the currently selected song's information from every array
        selectedGenreTitles.remove(at: currentSong)
        selectedGenreArtists.remove(at: currentSong)
        selectedGenreAlbums.remove(at: currentSong)
        selectedGenreAlbumCovers.remove(at: currentSong)
        
        //if the titles array is empty, refills the arrays with their original contents via the backups created earlier
        if selectedGenreTitles.count == 0 {
            selectedGenreTitles = backup1
            selectedGenreArtists = backup2
            selectedGenreAlbums = backup3
            selectedGenreAlbumCovers = backup4
        }
        
        //performs the startup function
        startup()
    }

    //creates a button action for the ok title button
    @IBAction func okTitle(_ sender: UIButton) {
        
        //disables user interaction for the title ok button and text box
        okTitleButton.isUserInteractionEnabled = false
        titleTextBox.isUserInteractionEnabled = false
        
        //takes the string the user inputted in the text box and manipulates it to remove any spaces or special characters and uppercases the entire string
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
        
        //takes the string of the current title variables and manipulates it to remove any spaces or special characters and uppercases the entire string
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
        
        //performs the easter egg function
        easterEgg()
        
        //checks to see if the user's input matches the answer; if it does, distributes points and transition the answer indicator to correct, if it does not, removes a life and transitions the answer indicator to incorrect
        if userTitle == currentTitle {
            titleAnswer.isHidden = false
            UIView.transition(with: self.titleAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.titleAnswer.image = #imageLiteral(resourceName: "CheckMark.png")}, completion: nil)
            titleCorrect = distributePoints()
        } else {
            titleAnswer.isHidden = false
            UIView.transition(with: self.titleAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.titleAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            playerLives -= 1
            livesLost += 1
            titleCorrect = 0
        }
        
        //performs the check function
        tripleCheck()
        
    }
    
    //creates a button action for the ok artist button
    @IBAction func okArtist(_ sender: UIButton) {
        
        //disables user interaction for the artist ok button and text box
        okArtistButton.isUserInteractionEnabled = false
        artistTextBox.isUserInteractionEnabled = false
        
        //takes the string the user inputted in the text box and manipulates it to remove any spaces or special characters and uppercases the entire string
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
        
        //takes the string of the current artist variables and manipulates it to remove any spaces or special characters and uppercases the entire string
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
        
        //checks to see if the user's input matches the answer; if it does, distributes points and transition the answer indicator to correct, if it does not, removes a life and transitions the answer indicator to incorrect
        if userArtist == currentArtist {
            artistAnswer.isHidden = false
            UIView.transition(with: self.artistAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.artistAnswer.image = #imageLiteral(resourceName: "CheckMark.png")}, completion: nil)
            artistCorrect = distributePoints()
        } else {
            artistAnswer.isHidden = false
            UIView.transition(with: self.artistAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.artistAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            playerLives -= 1
            livesLost += 1
            artistCorrect = 0
        }
        
        //performs the check function
        tripleCheck()
        
    }
    
    //creates a button action for the ok album button
    @IBAction func okAlbum(_ sender: UIButton) {
        
        //disables user interaction for the artist ok button and text box
        okAlbumButton.isUserInteractionEnabled = false
        albumTextBox.isUserInteractionEnabled = false
        
        //takes the string the user inputted in the text box and manipulates it to remove any spaces or special characters and uppercases the entire string
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
        
        //takes the string of the current album variables and manipulates it to remove any spaces or special characters and uppercases the entire string
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
        
        //checks to see if the user's input matches the answer; if it does, distributes points and transition the answer indicator to correct, if it does not, removes a life and transitions the answer indicator to incorrect
        if userAlbum == currentAlbum {
            albumAnswer.isHidden = false
            UIView.transition(with: self.albumAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumAnswer.image = #imageLiteral(resourceName: "CheckMark.png")}, completion: nil)
            albumCorrect = distributePoints()
        } else {
            albumAnswer.isHidden = false
            UIView.transition(with: self.albumAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            playerLives -= 1
            livesLost += 1
            albumCorrect = 0
        }
        
        //performs the check function
        tripleCheck()
        
    }
    
    //creates the easter egg function
    func easterEgg() {
        
        //if my favorite song plays and user answers saying it's my facorite song, as long as they didn't find a vinyl crown, they have their lives refilled
        if currentTitle == "NOTYPE" && userTitle == "SHAYNSFAVORITESONG" && vinylCrown == false {
            
            playerLives = 6
            audioPlayer?.stop()
            timer?.invalidate()
            timer = nil
            timeLeft = 45
            
            //creates an alert controller congratulating the user on finding the easter egg and gives them the option to go the secret level
            let alertController = UIAlertController(title: "Couldn't have said it better myself", message:
                "Congrats on finding my favorite song! Your lives have been restored to full. Wanna head to the secret level?", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Keep playing", style: .default, handler: { action in
                
                //gives the player 24 points for finding the secret easter egg
                playerScore += 24
                
                //performs a segue back tot the singleplayer view controller
                self.performSegue(withIdentifier: "backToGame", sender: nil)
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Go to secret level", style: .default, handler: { action in
                
                //performs a segue to the secret level
                self.performSegue(withIdentifier: "toEasterEgg", sender: nil)
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
}

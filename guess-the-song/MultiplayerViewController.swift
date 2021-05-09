//
//  MultiplayerViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-01.
//

import UIKit
import AVFoundation

class MultiplayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if mPlayer1Lives < 0 {
            mPlayer1Lives = 0
        }
        
        if mPlayer2Lives < 0 {
            mPlayer2Lives = 0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        func startup() {
            let alert = UIAlertController(title: "Player 1, what's your name?", message: nil, preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your name here..."
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                startup2()
                mPlayer1Name = (alert.textFields?.first!.text)!
            }))
            
            self.present(alert, animated: true)
        }
        
        func startup2() {
            let alert = UIAlertController(title: "Player 2, what's your name?", message: nil, preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Input your name here..."
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                mPlayer2Name = (alert.textFields?.first!.text)!
                
                //sets the player labels equal to the players' names
                self.scoreLabel.text = "\(mPlayer1Name)'s Score: \(mPlayer1Score)"
                self.livesLabel.text = "\(mPlayer1Name)'s Lives: \(mPlayer1Lives)"
                self.vinylsLabel.text = "\(mPlayer1Name)'s Vinyls: \(mPlayer1Vinyls)"
                
                self.scoreLabel2.text = "\(mPlayer2Name)'s Score: \(mPlayer1Score)"
                self.livesLabel2.text = "\(mPlayer2Name)'s Lives: \(mPlayer1Lives)"
                self.vinylsLabel2.text = "\(mPlayer2Name)'s Vinyls: \(mPlayer1Vinyls)"
                
            }))
            
            self.present(alert, animated: true)
        }
        
        if isStartupFinished == false {
            isStartupFinished = true
            startup()
        } else {
            scoreLabel.text = "\(mPlayer1Name)'s Score: \(mPlayer1Score)"
            livesLabel.text = "\(mPlayer1Name)'s Lives: \(mPlayer1Lives)"
            vinylsLabel.text = "\(mPlayer1Name)'s Vinyls: \(mPlayer1Vinyls)"
            
            scoreLabel2.text = "\(mPlayer2Name)'s Score: \(mPlayer2Score)"
            livesLabel2.text = "\(mPlayer2Name)'s Lives: \(mPlayer2Lives)"
            vinylsLabel2.text = "\(mPlayer2Name)'s Vinyls: \(mPlayer2Vinyls)"
        }
        
        resetForVinyl()
        
        if mPlayerTurn % 2 == 0 {
            turnIndicator.text = "\(mPlayer1Name)'s Turn"
        } else if mPlayerTurn % 2 == 1 {
            turnIndicator.text = "\(mPlayer2Name)'s Turn"
        }
        
        if mPlayer1Vinyls == 5 {
            mPlayer1Score *= 2
            
            mFirstLoad = false
            mSelectedGenreTitles = mBackup1
            mSelectedGenreArtists = mBackup2
            mSelectedGenreAlbums = mBackup3
            mSelectedGenreAlbumCovers = mBackup4
            
            scoreLabel.text = "\(mPlayer1Name)'s Score: \(mPlayer1Score)"
            
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            let alertController = UIAlertController(title: "Game finished!", message:
                "Congratulations \(mPlayer1Name)! You obtained all 5 vinyls and beat \(mPlayer2Name)! Your total score was doubled for beating the game and your final score is now \(mPlayer1Score). \(mPlayer2Name)'s final score was \(mPlayer2Score). Well done \(mPlayer1Name)!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
                
                self.saveData()
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        } else if mPlayer2Vinyls == 5 {
            mPlayer2Score *= 2
            
            mFirstLoad = false
            mSelectedGenreTitles = mBackup1
            mSelectedGenreArtists = mBackup2
            mSelectedGenreAlbums = mBackup3
            mSelectedGenreAlbumCovers = mBackup4
            
            scoreLabel2.text = "\(mPlayer2Name)'s Score: \(mPlayer2Score)"
            
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            let alertController = UIAlertController(title: "Game finished!", message:
                "Congratulations \(mPlayer2Name)! You obtained all 5 vinyls and beat \(mPlayer1Name)! Your total score was doubled for beating the game and your final score is now \(mPlayer2Score). \(mPlayer1Name)'s final score was \(mPlayer1Score). Well done \(mPlayer2Name)!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
                
                self.saveData2()
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        if mPlayer1Lives == 0 {
            
            mFirstLoad = false
            mSelectedGenreTitles = mBackup1
            mSelectedGenreArtists = mBackup2
            mSelectedGenreAlbums = mBackup3
            mSelectedGenreAlbumCovers = mBackup4
            
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            let alertController = UIAlertController(title: "Game over", message:
                "\(mPlayer1Name) ran out of lives, so \(mPlayer2Name) automatically wins! Better listen to some more music and then try again! \(mPlayer1Name)'s final score was \(mPlayer1Score), and \(mPlayer2Name)'s final score was \(mPlayer2Score).", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
                
                self.saveData2()
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        } else if mPlayer2Lives == 0 {
            
            mFirstLoad = false
            mSelectedGenreTitles = mBackup1
            mSelectedGenreArtists = mBackup2
            mSelectedGenreAlbums = mBackup3
            mSelectedGenreAlbumCovers = mBackup4
            
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            let alertController = UIAlertController(title: "Game over", message:
                "\(mPlayer2Name) ran out of lives, so \(mPlayer1Name) automatically wins! Better listen to some more music and then try again! \(mPlayer2Name)'s final score was \(mPlayer2Score), and \(mPlayer1Name)'s final score was \(mPlayer1Score).", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
                
                self.saveData()
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
                UILabel.transition(with: self.turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.turnIndicator.isHidden = true
                }
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func unwindToMultiplayer(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func multiplayerBackButton(_ sender: UIButton) {
        firstLoad = false
        performSegue(withIdentifier: "multiplayerBack", sender: nil)
    }
    
    var images: [UIImage] = [#imageLiteral(resourceName: "clef.png"),#imageLiteral(resourceName: "drums.png"),#imageLiteral(resourceName: "equalizer.png"),#imageLiteral(resourceName: "headphones.png"),#imageLiteral(resourceName: "microphone.png"),#imageLiteral(resourceName: "note.png"),#imageLiteral(resourceName: "piano.png"),#imageLiteral(resourceName: "play.png"),#imageLiteral(resourceName: "vinyl.png")]
    
    var shuffledImages: [UIImage] = []
    
    var currentButton = 0
    
    var myIndex = 0
    
    //reloads the saved array
    func loadData() {
        if let loadNames: [String] = UserDefaults.standard.value(forKey: "save2") as? [String] {
            savedData2 = loadNames
        }
    }
    
    //creates variables to save scores and names
    var savedData2: [String] = []
    var savedScores2 = UserDefaults.standard
    var superScore = ""
    var superScore2 = ""
    var superGenre = ""
    
    //allows access to leaderboard variables
    let leaderboard = LeaderboardViewController()
    
    @IBOutlet var positions: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var livesLabel: UILabel!
    
    @IBOutlet weak var vinylsLabel: UILabel!
    
    @IBOutlet weak var scoreLabel2: UILabel!
    
    @IBOutlet weak var vinylsLabel2: UILabel!
    
    @IBOutlet weak var livesLabel2: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var turnIndicator: UILabel!
    
    @IBAction func startGame(_ sender: UIButton) {
        
        images = [#imageLiteral(resourceName: "clef.png"),#imageLiteral(resourceName: "drums.png"),#imageLiteral(resourceName: "equalizer.png"),#imageLiteral(resourceName: "headphones.png"),#imageLiteral(resourceName: "microphone.png"),#imageLiteral(resourceName: "note.png"),#imageLiteral(resourceName: "piano.png"),#imageLiteral(resourceName: "play.png"),#imageLiteral(resourceName: "vinyl.png")]
        shuffledImages = []
        
        resetAll()
        
        mPlayerTurn = 2
        
        mVinylCrown = false
        
        mPlayer1Score = 0
        mPlayer1Lives = 6
        mPlayer1Vinyls = 0
        scoreLabel.text = "\(mPlayer1Name)'s Score: \(mPlayer1Score)"
        livesLabel.text = "\(mPlayer1Name)'s Lives: \(mPlayer1Lives)"
        vinylsLabel.text = "\(mPlayer1Name)'s Vinyls: \(mPlayer1Vinyls)"
        
        mPlayer2Score = 0
        mPlayer2Lives = 6
        mPlayer2Vinyls = 0
        scoreLabel2.text = "\(mPlayer2Name)'s Score: \(mPlayer1Score)"
        livesLabel2.text = "\(mPlayer2Name)'s Lives: \(mPlayer1Lives)"
        vinylsLabel2.text = "\(mPlayer2Name)'s Vinyls: \(mPlayer1Vinyls)"
        
        
        UILabel.transition(with: turnIndicator, duration: 0.7, options: .transitionFlipFromTop, animations: {self.turnIndicator}, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.turnIndicator.isHidden = false
        }
        
        turnIndicator.text = "\(mPlayer1Name)'s Turn"
        
        //hides the start game button with an animation
        UIButton.transition(with: startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.startButton.isHidden = true
        }
        
        //enables user interaction for every button
        for position in positions {
            position.isUserInteractionEnabled = true
        }
        
        //shuffles the images
        images.shuffle()
        for index in images.reversed() {
            shuffledImages.append(index)
        }
        
    }
    
    func resetForVinyl() {
        if mVinylCrown == true {
            
            for position in positions {
                position.isUserInteractionEnabled = true
            }
            
            mVinylCrown = false
            images = [#imageLiteral(resourceName: "clef.png"),#imageLiteral(resourceName: "drums.png"),#imageLiteral(resourceName: "equalizer.png"),#imageLiteral(resourceName: "headphones.png"),#imageLiteral(resourceName: "microphone.png"),#imageLiteral(resourceName: "note.png"),#imageLiteral(resourceName: "piano.png"),#imageLiteral(resourceName: "play.png"),#imageLiteral(resourceName: "vinyl.png")]
            shuffledImages = []
            images.shuffle()
            for index in images.reversed() {
                shuffledImages.append(index)
            }
            
            resetAll()
            
        }
    }
    
    func resetAll() {
        
        //checks all of the buttons to see if their image is not equal to the default logo
        view.isUserInteractionEnabled = false
        
        if positions[myIndex].currentImage != #imageLiteral(resourceName: "BackLogo") {
            
            //after 0.4 seconds, reverts the image back to the default avengers logo with an animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                UIButton.transition(with: self.positions[self.myIndex], duration: 0.4, options: .transitionFlipFromLeft, animations: {self.positions[self.myIndex].setImage(#imageLiteral(resourceName: "BackLogo"), for: .normal)}, completion: nil)
                
                //increments the index variable
                self.myIndex += 1
                
                //stops if the index variable is equal to 16
                if self.myIndex == 9 {
                    self.myIndex = 0
                    self.view.isUserInteractionEnabled = true
                    return
                }
                self.resetAll()
            }
        } else {
            
            //increments the index variable
            self.myIndex += 1
            
            //stops if the index variable is equal to 16
            if self.myIndex == 9 {
                myIndex = 0
                view.isUserInteractionEnabled = true
                return
            }
            self.resetAll()
        }
    }
    
    func saveData() {
        let alert = UIAlertController(title: "Outstanding", message: "Your incredible achievement has been etched in the immortal leaderboard of this app. Congratulations once again!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            switch mPlayer1Score {
            case 0...9:
                self.superScore = "000\(mPlayer1Score)"
            case 10...99:
                self.superScore = "00\(mPlayer1Score)"
            case 100...999:
                self.superScore = "0\(mPlayer1Score)"
            default:
                self.superScore = String(playerScore)
            }
            
            switch mPlayer2Score {
            case 0...9:
                self.superScore2 = "000\(mPlayer2Score)"
            case 10...99:
                self.superScore2 = "00\(mPlayer2Score)"
            case 100...999:
                self.superScore2 = "0\(mPlayer2Score)"
            default:
                self.superScore2 = String(mPlayer2Score)
            }
            
            if mBackup1.contains("Mask Off") {
                self.superGenre = "Rap"
            } else if mBackup1.contains("Dangerous Woman") {
                self.superGenre = "Pop"
            } else if mBackup1.contains("September") {
                self.superGenre = "70s"
            }
            
            self.savedData2.append("Genre: \(self.superGenre), \(mPlayer1Name)'s Score: \(self.superScore),  \(mPlayer2Name)'s Score: \(self.superScore2), Winner: \(mPlayer1Name)")
            self.savedScores2.set(self.savedData2, forKey: "save2")
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func saveData2() {
        let alert = UIAlertController(title: "Outstanding", message: "Your incredible achievement has been etched in the immortal leaderboard of this app. Congratulations once again!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            switch mPlayer1Score {
            case 0...9:
                self.superScore = "000\(mPlayer1Score)"
            case 10...99:
                self.superScore = "00\(mPlayer1Score)"
            case 100...999:
                self.superScore = "0\(mPlayer1Score)"
            default:
                self.superScore = String(playerScore)
            }
            
            switch mPlayer2Score {
            case 0...9:
                self.superScore2 = "000\(mPlayer2Score)"
            case 10...99:
                self.superScore2 = "00\(mPlayer2Score)"
            case 100...999:
                self.superScore2 = "0\(mPlayer2Score)"
            default:
                self.superScore2 = String(mPlayer2Score)
            }
            
            if mBackup1.contains("Mask Off") {
                self.superGenre = "Rap"
            } else if mBackup1.contains("Dangerous Woman") {
                self.superGenre = "Pop"
            } else if mBackup1.contains("September") {
                self.superGenre = "70s"
            }
            
            self.savedData2.append("Genre: \(self.superGenre), \(mPlayer1Name)'s Score: \(self.superScore),  \(mPlayer2Name)'s Score: \(self.superScore2), Winner: \(mPlayer2Name)")
            self.savedScores2.set(self.savedData2, forKey: "save2")
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func flipPicture(_ sender: UIButton) {
        
        //when a button is pressed, sets the currentButton variable to the tag of the sender, disables user interaction for the sender and reveals the images with an animation
        currentButton = sender.tag
        sender.isUserInteractionEnabled = false
        UIButton.transition(with: positions[currentButton], duration: 0.4, options: .transitionFlipFromLeft, animations: {sender.setImage(self.shuffledImages[self.currentButton], for: .normal)}, completion: nil)
        
        if positions[currentButton].image(for: .normal) != #imageLiteral(resourceName: "vinyl.png") {
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.performSegue(withIdentifier: "multiplayerSongSwitch", sender: nil)
                
                self.view.isUserInteractionEnabled = true
                
            }
        } else if positions[currentButton].image(for: .normal) == #imageLiteral(resourceName: "vinyl.png") {
            
            mVinylCrown = true
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.performSegue(withIdentifier: "multiplayerSongSwitch", sender: nil)
                
                self.view.isUserInteractionEnabled = true
                
            }
        }
        
    }
    
}

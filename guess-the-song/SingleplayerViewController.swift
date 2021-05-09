//
//  SingleplayerViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-05-24.
//

import UIKit
import AVFoundation

class SingleplayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadData()
        // Do any additional setup after loading the view.
    }
    
    //reloads the saved array
    func loadData() {
        if let loadNames: [String] = UserDefaults.standard.value(forKey: "save") as? [String] {
            savedData = loadNames
        }
    }
    
    //creates variables to save scores and names
    var savedData: [String] = []
    var savedScores = UserDefaults.standard
    var superScore = ""
    var superGenre = ""
    
    //allows access to leaderboard variables
    let leaderboard = LeaderboardViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        if playerLives < 0 {
            playerLives = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        resetForVinyl()
        
        scoreLabel.text = "Score: \(playerScore)"
        livesLabel.text = "Lives: \(playerLives)"
        vinylsLabel.text = "Vinyls: \(vinyls)"
        
        if vinyls == 5 {
            playerScore *= 2
            firstLoad = false
            selectedGenreTitles = backup1
            selectedGenreArtists = backup2
            selectedGenreAlbums = backup3
            selectedGenreAlbumCovers = backup4
            
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            let alertController = UIAlertController(title: "Game finished!", message:
                "Congratulations! You obtained all 5 vinyls! Your total score was doubled for beating the game and your final score is now \(playerScore). Well done!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
                
                self.saveData()
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        if playerLives == 0 {
            firstLoad = false
            selectedGenreTitles = backup1
            selectedGenreArtists = backup2
            selectedGenreAlbums = backup3
            selectedGenreAlbumCovers = backup4
            
            for position in positions {
                position.isUserInteractionEnabled = false
            }
            
            let alertController = UIAlertController(title: "Game over", message:
                "You ran out of lives! Better listen to some more music and then try again! Your final score was \(playerScore).", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Enter the leaderboard", style: .default, handler: { action in
                
                self.saveData()
                
                UIButton.transition(with: self.startButton, duration: 0.7, options: .transitionFlipFromTop, animations: {self.startButton}, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.startButton.isHidden = false
                }
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func unwindToSingleplayer(_ unwindSegue: UIStoryboardSegue) {

    }
    
    @IBAction func singleplayerBackButton(_ sender: UIButton) {
        firstLoad = false
        performSegue(withIdentifier: "singleplayerBack", sender: nil)
    }
    
    var images: [UIImage] = [#imageLiteral(resourceName: "clef.png"),#imageLiteral(resourceName: "drums.png"),#imageLiteral(resourceName: "equalizer.png"),#imageLiteral(resourceName: "headphones.png"),#imageLiteral(resourceName: "microphone.png"),#imageLiteral(resourceName: "note.png"),#imageLiteral(resourceName: "piano.png"),#imageLiteral(resourceName: "play.png"),#imageLiteral(resourceName: "vinyl.png")]
    
    var shuffledImages: [UIImage] = []
    
    var currentButton = 0
    
    var myIndex = 0
    
    @IBOutlet var positions: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var livesLabel: UILabel!
    
    @IBOutlet weak var vinylsLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startGame(_ sender: UIButton) {
    
        images = [#imageLiteral(resourceName: "clef.png"),#imageLiteral(resourceName: "drums.png"),#imageLiteral(resourceName: "equalizer.png"),#imageLiteral(resourceName: "headphones.png"),#imageLiteral(resourceName: "microphone.png"),#imageLiteral(resourceName: "note.png"),#imageLiteral(resourceName: "piano.png"),#imageLiteral(resourceName: "play.png"),#imageLiteral(resourceName: "vinyl.png")]
        shuffledImages = []
        
        resetAll()
        
        playerScore = 0
        playerLives = 6
        vinyls = 0
        scoreLabel.text = "Score: \(playerScore)"
        livesLabel.text = "Lives: \(playerLives)"
        vinylsLabel.text = "Vinyls: \(vinyls)"
        
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
        if vinylCrown == true {
            
            for position in positions {
                position.isUserInteractionEnabled = true
            }
            
            vinylCrown = false
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
        let alert = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            switch playerScore {
            case 0...9:
                self.superScore = "000\(playerScore)"
            case 10...99:
                self.superScore = "00\(playerScore)"
            case 100...999:
                self.superScore = "0\(playerScore)"
            default:
                self.superScore = String(playerScore)
            }
            
            if backup1.contains("Mask Off") {
                self.superGenre = "Rap"
            } else if backup1.contains("Dangerous Woman") {
                self.superGenre = "Pop"
            } else if backup1.contains("September") {
                self.superGenre = "70s"
            }
            
            self.savedData.append("Score: \(self.superScore), Genre: \(self.superGenre), Player: \((alert.textFields?.first!.text)!)")
            self.savedScores.set(self.savedData, forKey: "save")
            
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
            self.performSegue(withIdentifier: "songSwitch", sender: nil)
            
                self.view.isUserInteractionEnabled = true
                
            }
        } else if positions[currentButton].image(for: .normal) == #imageLiteral(resourceName: "vinyl.png") {
            
            vinylCrown = true
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.performSegue(withIdentifier: "songSwitch", sender: nil)
                
                self.view.isUserInteractionEnabled = true
                
            }
        }
        
    }
    
}

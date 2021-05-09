//
//  CampaignsViewController.swift
//  guess-the-song
//
//  Created by Shayn Adatia on 2019-06-05.\
//

import UIKit
import AVFoundation

class CampaignsViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        scoreLabel.text = "Score: \(playerScore)"
        
        currentSong = Int.random(in: 0...currentTitles.count-1)
        
        currentTitle = currentTitles[currentSong]
        
        currentAlbum = currentAlbums[currentSong]
        
        currentAlbumCover = currentAlbumCovers[currentSong]
        
        startup()
        
    }
    
    var correctTitles = 0
    var correctAlbums = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var albumTextBox: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleAnswer: UIImageView!
    @IBOutlet weak var albumAnswer: UIImageView!
    
    @IBOutlet weak var okTitleButton: UIButton!
    @IBOutlet weak var okAlbumButton: UIButton!
    
    @IBOutlet weak var giveUpButton: UIButton!
    @IBOutlet weak var nextSongButton: UIButton!
    
    @IBOutlet weak var albumCover: UIImageView!
    
    @IBAction func backButton(_ sender: UIButton) {
        audioPlayer?.stop()
        performSegue(withIdentifier: "resetToMainMenu", sender: nil)
    }
    
    var audioPlayer: AVAudioPlayer?
    
    var currentSong = 0
    
    var currentTitle = ""
    var currentAlbum = ""
    var currentAlbumCover = #imageLiteral(resourceName: "Views.jpg")
    
    var userTitle = ""
    var userAlbum = ""
    
    var titleCorrect = 0
    var albumCorrect = 0
    
    var currentScore = 0
    var totalScore = 0
    
    var timer:Timer?
    var timeLeft = 45
    
    @IBAction func giveUp(_ sender: UIButton) {
        
        audioPlayer?.stop()
        timer?.invalidate()
        timer = nil
        timeLeft = 45
        
        okTitleButton.isUserInteractionEnabled = false
        titleTextBox.isUserInteractionEnabled = false
        
        okAlbumButton.isUserInteractionEnabled = false
        albumTextBox.isUserInteractionEnabled = false
        
        let alertController = UIAlertController(title: "Good effort!", message:
            "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Album: \(albumCorrect) points.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
            
            self.totalScore += self.currentScore
            self.currentScore = 0
            currentTitles.remove(at: self.currentSong)
            currentAlbums.remove(at: self.currentSong)
            currentAlbumCovers.remove(at: self.currentSong)
            self.winCheck()
            self.scoreLabel.text = "Score: \(self.totalScore)"
            self.giveUpButton.isUserInteractionEnabled = false
            self.nextSongButton.isUserInteractionEnabled = true
            self.titleCorrect = 0
            self.albumCorrect = 0
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func decreaseTimer()
    {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            
            audioPlayer?.stop()
            timer!.invalidate()
            timer = nil
            
            let alertController = UIAlertController(title: "Times up!", message:
                "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Album: \(albumCorrect) points.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                
                self.totalScore += self.currentScore
                self.currentScore = 0
                currentTitles.remove(at: self.currentSong)
                currentAlbums.remove(at: self.currentSong)
                currentAlbumCovers.remove(at: self.currentSong)
                self.winCheck()
                self.scoreLabel.text = "Score: \(self.totalScore)"
                self.giveUpButton.isUserInteractionEnabled = false
                self.nextSongButton.isUserInteractionEnabled = true
                self.titleCorrect = 0
                self.albumCorrect = 0
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func winCheck() {
        if currentTitles.isEmpty {
            totalScore *= 2
            
            let alertController = UIAlertController(title: "Game finished!", message:
                "You finished the game! You got \(correctTitles) titles correct and \(correctAlbums) albums correct. Your total score was doubled for finishing the game and your final score is now \(totalScore)", preferredStyle: .alert)
            
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
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.decreaseTimer), userInfo: nil, repeats: true)
            UIView.transition(with: self.albumCover, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumCover.image = self.currentAlbumCover}, completion: nil)
            
            
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
    
    func doubleCheck() {
        
        if okTitleButton.isUserInteractionEnabled == false && okAlbumButton.isUserInteractionEnabled == false {
            
            audioPlayer?.stop()
            timer?.invalidate()
            timer = nil
            timeLeft = 45
            
            if titleAnswer.image == #imageLiteral(resourceName: "XMark") && albumAnswer.image == #imageLiteral(resourceName: "XMark") {
                
                let alertController = UIAlertController(title: "Better luck next round!", message:
                    "Unfortunately, you got both the title and album wrong. Shame on you. Go listen to some music and then keep playing.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    self.totalScore += self.currentScore
                    self.currentScore = 0
                    currentTitles.remove(at: self.currentSong)
                    currentAlbums.remove(at: self.currentSong)
                    currentAlbumCovers.remove(at: self.currentSong)
                    self.winCheck()
                    self.scoreLabel.text = "Score: \(self.totalScore)"
                    self.giveUpButton.isUserInteractionEnabled = false
                    self.nextSongButton.isUserInteractionEnabled = true
                    self.titleCorrect = 0
                    self.albumCorrect = 0
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Well done!", message:
                    "You obtained \(currentScore) points! Here are your results, Title: \(titleCorrect) points, Album: \(albumCorrect) points.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { action in
                    
                    self.totalScore += self.currentScore
                    self.currentScore = 0
                    currentTitles.remove(at: self.currentSong)
                    currentAlbums.remove(at: self.currentSong)
                    currentAlbumCovers.remove(at: self.currentSong)
                    self.winCheck()
                    self.scoreLabel.text = "Score: \(self.totalScore)"
                    self.giveUpButton.isUserInteractionEnabled = false
                    self.nextSongButton.isUserInteractionEnabled = true
                    self.titleCorrect = 0
                    self.albumCorrect = 0
                    
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
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
            correctTitles += 1
        } else {
            titleAnswer.isHidden = false
            UIView.transition(with: self.titleAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.titleAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            playerLives -= 1
            titleCorrect = 0
        }
        
        doubleCheck()
        
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
            correctAlbums += 1
        } else {
            albumAnswer.isHidden = false
            UIView.transition(with: self.albumAnswer, duration: 0.7, options: .transitionFlipFromRight, animations: {self.albumAnswer.image = #imageLiteral(resourceName: "XMark")}, completion: nil)
            playerLives -= 1
            albumCorrect = 0
        }
        
        doubleCheck()
        
    }
    
    @IBAction func nextSong(_ sender: UIButton) {
        
        titleAnswer.image = nil
        albumAnswer.image = nil
        
        currentSong = Int.random(in: 0...currentTitles.count-1)
        currentTitle = currentTitles[currentSong]
        currentAlbum = currentAlbums[currentSong]
        currentAlbumCover = currentAlbumCovers[currentSong]
        
        okTitleButton.isUserInteractionEnabled = true
        titleTextBox.isUserInteractionEnabled = true
        
        okAlbumButton.isUserInteractionEnabled = true
        albumTextBox.isUserInteractionEnabled = true
        
        titleTextBox.text?.removeAll()
        albumTextBox.text?.removeAll()
        
        self.giveUpButton.isUserInteractionEnabled = true
        self.nextSongButton.isUserInteractionEnabled = false
        
        startup()
    }
    
}

//
//  ViewController.swift
//  CatchTheBoeyGame
//
//  Created by Tahir Atakan Can on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var boeyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var boey1: UIImageView!
    @IBOutlet weak var boey2: UIImageView!
    @IBOutlet weak var boey3: UIImageView!
    @IBOutlet weak var boey4: UIImageView!
    @IBOutlet weak var boey5: UIImageView!
    @IBOutlet weak var boey6: UIImageView!
    @IBOutlet weak var boey7: UIImageView!
    @IBOutlet weak var boey8: UIImageView!
    @IBOutlet weak var boey9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score \(score)"
        
        // HighScore Check
        
        let stroedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if stroedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore : \(highScore)"
        }
        if let newScore = stroedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text  = "Highscore : \(highScore)"
        }
        
        
        
        
        boey1.isUserInteractionEnabled = true
        boey2.isUserInteractionEnabled = true
        boey3.isUserInteractionEnabled = true
        boey4.isUserInteractionEnabled = true
        boey5.isUserInteractionEnabled = true
        boey6.isUserInteractionEnabled = true
        boey7.isUserInteractionEnabled = true
        boey8.isUserInteractionEnabled = true
        boey9.isUserInteractionEnabled = true
        
        
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        boey1.addGestureRecognizer(recognizer1)
        boey2.addGestureRecognizer(recognizer2)
        boey3.addGestureRecognizer(recognizer3)
        boey4.addGestureRecognizer(recognizer4)
        boey5.addGestureRecognizer(recognizer5)
        boey6.addGestureRecognizer(recognizer6)
        boey7.addGestureRecognizer(recognizer7)
        boey8.addGestureRecognizer(recognizer8)
        boey9.addGestureRecognizer(recognizer9)
        
        boeyArray = [boey1, boey2, boey3, boey4, boey5, boey6, boey7, boey8, boey9]
        
        // Timers
        counter = 15
        timeLabel.text = "\(timer)" //String(timer)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideBoey), userInfo: nil, repeats: true)
         
        
        hideBoey()
        
    }
    
    
    @objc func hideBoey() {
        
        //boey1.isHidden = true
        for boey in boeyArray {
            boey.isHidden = true
        }
        
        // arc4random_uniform(UInt32(boeyArray.count)) bu app çöker
        let random = Int(arc4random_uniform(UInt32(boeyArray.count - 1)))
        boeyArray[random].isHidden = false
        
    }
    
    
    
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score \(score)"
    }

    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for boey in boeyArray {
                boey.isHidden = true
            }
            
            // High Score
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = String(self.highScore)
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            // Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                self.score = 0 // self kullanımı
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 15
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideBoey), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    
    
}


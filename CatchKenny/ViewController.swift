//
//  ViewController.swift
//  CatchKenny
//
//  Created by Bahadır Çokdilli on 22.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var randomX = 0
    var randomY = 0
    var image = UIImage(named: "KennyMcCormick")
    var imageView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 100, y: 400, width: 128, height: 128)
        view.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        
        counter = 10
        score = 0
        timerLabel.text = "Time: \(counter)"
        scoreLabel.text = "Score: \(score)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if let highScoreData = storedHighScore as? Int {
            highScore = highScoreData
            highScoreLabel.text = "High Score: \(highScore)"
        } else {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
    }
    
    @objc func timerFunc() {
        if counter == 0 {
            timer.invalidate()
            imageView.isHidden = true
            alertFunc(x: "Time is Over!",y: "Do you want to play again?")
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
        }
        
        timerLabel.text = "Time: \(counter)"
        counter -= 1
        
        randomX = Int.random(in: 25..<225)
        randomY = Int.random(in: 200..<600)
        
        imageView.frame = CGRect(x: Float64(randomX), y: Float64(randomY), width: imageView.frame.size.width, height: imageView.frame.size.height)
    }
    
    func alertFunc(x: String, y: String) {
        let alert = UIAlertController(title: x, message: y, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        let retryButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.counter = 10
            self.score = 0
            self.timerLabel.text = "Time: \(self.counter)"
            self.scoreLabel.text = "Score: \(self.score)"
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            
            self.imageView.isHidden = false
        }
        alert.addAction(okButton)
        alert.addAction(retryButton)
        self.present(alert, animated: true)
    }
    
    @objc func imageClicked() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        randomX = Int.random(in: 25..<225)
        randomY = Int.random(in: 200..<600)
        
        imageView.frame = CGRect(x: Float64(randomX), y: Float64(randomY), width: imageView.frame.size.width, height: imageView.frame.size.height)
    }


}

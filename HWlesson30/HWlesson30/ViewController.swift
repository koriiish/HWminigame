//
//  ViewController.swift
//  HWlesson30
//
//  Created by Карина Дьячина on 26.03.24.
//

import UIKit

class ViewController: UIViewController {
    
    var startGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Start game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var levelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mini game: guess a number from 1 fo 3"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var game = Game()
    var score = 0
    var level = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupButton()
        setupLabels()
        
        //  score = UserDefaults.standard.integer(forKey: "score")
        //  level =  UserDefaults.standard.integer(forKey: "level")
        //  levelLabel.text = "\(UserDefaults.standard.string(forKey: "levelLabel") ?? "0")"
        //  scoreLabel.text = "\(UserDefaults.standard.string(forKey: "scoreLabel") ?? "0")"
        
        score = SettingsManager.score
        level = SettingsManager.level
        scoreLabel.text = "\(SettingsManager.scoreLabel)"
        levelLabel.text = "\(SettingsManager.levelLabel)"
        
    }
    
    func setupLabels() {
        view.addSubview(scoreLabel)
        view.addSubview(levelLabel)
        view.addSubview(gameLabel)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 220),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
            
            levelLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            levelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            levelLabel.heightAnchor.constraint(equalToConstant: 40),
            
            gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 550),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupButton() {
        view.addSubview(startGameButton)
        
        NSLayoutConstraint.activate([
            startGameButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.widthAnchor.constraint(equalToConstant: 150),
            startGameButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    
    @objc func startGame() {
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Mini game", message: "Guess a number from 1 fo 3", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.delegate = self
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [self]_ in
            resultLabel.text = String(self.game.isRight(answer: self.game.answer))
            //        let scoreText = scoreLabel.text
            //        UserDefaults.standard.set(scoreText, forKey: "scoreLabel")
            if resultLabel.text == "true" {
                score += 1
                //    UserDefaults.standard.set(score, forKey: "score")
                //    scoreLabel.text = "Score points: \(score)"
                
                scoreLabel.text = "Score points: \(score)"
                level = score / 2
                // UserDefaults.standard.set(level, forKey: "level")
                levelLabel.text = "Level: \(level)"
            }
            let levelText = levelLabel.text
            UserDefaults.standard.set(levelText, forKey: "levelLabel")
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true) {
            self.game.generateSecretNumber()
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let number = Int(text) {
            game.answer = number
        }
    }
    
}

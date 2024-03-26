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
        button.setTitle("Начать игру", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        return button
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество очков: "
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Уровень: "
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupLabels()
    }
    
    func setupLabels() {
        view.addSubview(scoreLabel)
        view.addSubview(levelLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
            
            levelLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            levelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            levelLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        view.addSubview(startGameButton)
        startGameButton.center = view.center
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }

    @objc func startGame() {
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Мини игра", message: "Угадай число от 1 до 10", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.delegate = self
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            print(self.game.isRight(answer: self.game.answer))
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

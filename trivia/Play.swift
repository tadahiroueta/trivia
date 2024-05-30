//
//  Play.swift
//  trivia
//
//  Created by Ueta, Lucas T on 2/21/24.
//

import UIKit

class Play: UIViewController {
    let questionLabel = UILabel(), optionsStack = UIStackView()
    let colorTime = 0.25, correctColor = UIColor(red: 57/255, green: 255/255, blue: 20/255, alpha: 1)
    var game: TriviaGame?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let stack = addScreenStack(to: view)
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        stack.distribution = .equalSpacing
        
        questionLabel.font = .systemFont(ofSize: 30)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        stack.addArrangedSubview(questionLabel)
        
        optionsStack.axis = .vertical
        optionsStack.spacing = 10
        stack.addArrangedSubview(optionsStack)
        optionsStack.translatesAutoresizingMaskIntoConstraints = false
        optionsStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
        
        for _ in 0..<4 { addOption("") }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        game = TriviaGame.game
        reset()
    }
    
    func addOption(_ text: String) {
        let option = UIButton()
        option.backgroundColor = .systemBlue
        option.setTitle(text, for: .normal)
        option.setTitleColor(.white, for: .normal)
        option.titleLabel?.textAlignment = .center
        option.titleLabel?.lineBreakMode = .byWordWrapping
        // TODO (if you can) add padding to the button
        option.layer.cornerRadius = 15
        option.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
        optionsStack.addArrangedSubview(option)
        option.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            option.widthAnchor.constraint(equalTo: optionsStack.widthAnchor),
            option.heightAnchor.constraint(greaterThanOrEqualToConstant: 75)
        ])
        option.sizeToFit()
    }
    
    @objc func handleAnswer(_ sender: UIButton) {
        let (isCorrect, correctAnswer) = game!.getCheck(answer: sender.currentTitle!)
        UIView.animate(withDuration: colorTime, animations: { () -> Void in
            if !isCorrect { sender.backgroundColor = .systemRed }
            for view in self.optionsStack.arrangedSubviews {
                let button = view as! UIButton
                guard button.currentTitle == correctAnswer else { continue }
                button.backgroundColor = self.correctColor
        }})
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(reset), userInfo: nil, repeats: false)
    }
    
    @objc func reset() {
        let results = game!.didGameEnd()
        guard results == nil else {
            let resultViewController = Result()
            resultViewController.points = results!.0
            resultViewController.total = results!.1
            present(resultViewController, animated: true)
            tabBarController?.selectedIndex = 0
            return
        }
        
        UIView.animate(withDuration: colorTime, animations: { () -> Void in for button in self.optionsStack.arrangedSubviews { button.backgroundColor = .systemBlue }})
        
        let trivia = game?.getTrivia()
        questionLabel.text = trivia?.question
        var options = [trivia!.correct] + trivia!.incorrect
        options.shuffle()
        for (view, newOption) in zip(self.optionsStack.arrangedSubviews, options) { (view as! UIButton).setTitle(newOption, for: .normal) }
    }
}


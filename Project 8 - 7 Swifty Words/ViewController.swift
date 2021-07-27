//
//  ViewController.swift
//  Project 8 - 7 Swifty Words
//
//  Created by Igor Polousov on 23.07.2021.
//

import UIKit

// Усли вы делаете интерфейс полностью при помощи кода, нужно полностью делать пометки что к чему относится чтобы в дальнейшем было понятно где какой элемент расположен на экране

class ViewController: UIViewController {

    var cluesLabel: UILabel!          // Label с подсказками слева сверху
    var answersLabel: UILabel!        // Label с введенными ответами пользователя справа сверху
    var currentUnswer: UITextField!   // Text Field с предполагаемыми ответами пользователя середина
    var scoreLabel: UILabel!          // Label с очками, правый верхний угол
    var letterButtons = [UIButton]()  // Массив кнопок в котором расположены кнопки с частями слов
    
    var activatedButtons = [UIButton]() // Кнопки которые уже нажал пользователь при вводе слова
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // Adding scoreLabel to view
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
//        scoreLabel.layer.borderWidth = 1
//        scoreLabel.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(scoreLabel)
        
        // Adding answerLabel to view
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.textAlignment = .right
        answersLabel.text = "ANSWERS"
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        //       answersLabel.layer.borderWidth = 2
        //       answersLabel.layer.borderColor = UIColor.red.cgColor
        view.addSubview(answersLabel)
        
        // Adding cluesLabel to view
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
//        cluesLabel.layer.borderWidth = 1
//        cluesLabel.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(cluesLabel)
        
        // Adding currentAnswer to view
        currentUnswer = UITextField()
        currentUnswer.translatesAutoresizingMaskIntoConstraints = false
        currentUnswer.font = UIFont.systemFont(ofSize: 44)
        currentUnswer.placeholder = "Tap letters to guess"
        currentUnswer.textAlignment = .center
        currentUnswer.isUserInteractionEnabled = false
//        currentUnswer.layer.borderWidth = 1
//        currentUnswer.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(currentUnswer)
        
        // Adding submit button to view
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submit.layer.borderWidth = 1
        submit.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(submit)
        
        // Adding Clear button
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        clear.layer.borderWidth = 1
        clear.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(clear)
        
        // Adding buttonsView
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            
            // Anchors for scoreLabel
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // Anchors for cluesLabel
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            // Anchors for answersLabel
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            // Anchors for currentAnswer text field
            currentUnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentUnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentUnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            // Anchors for submit button
            submit.topAnchor.constraint(equalTo: currentUnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            submit.widthAnchor.constraint(equalToConstant: 200),
            
            
            // Anchors for clear button
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            clear.widthAnchor.constraint(equalToConstant: 200),
            
            // Anchors to buttonView
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        
        ])
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
       
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentUnswer.text = currentUnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
        
    }

    
    @objc func submitTapped(_ sender: UIButton) {
        
        // Проверка что в поле с тектом currentAnswer введен какой-то текст, тогда переменная answerText будет иметь значение строки с введенным текстом
        guard let answerText = currentUnswer.text else { return }
        // Константа, которая определяет индекс введенного слова answerText в массиве solutions. Integer.
        if let solutionPosition = solutions.firstIndex(of: answerText){
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            

            answersLabel.text = splitAnswers?.joined(separator: "\n")
            currentUnswer.text = ""
            score += 1
 
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "You're ready for the next level", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
            
        } else {
            // Если игрок ввел неправильный ответ он получит сообщение
            let ac = UIAlertController(title: "It's wrong", message: "Entered word is wrong, please press Ok and tap letters again or press Next level to choose another one. Score deducted -1" , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: clearAction))
            ac.addAction(UIAlertAction(title: "Next level", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
      
    }
    
    func levelUp(action: UIAlertAction) {
        currentUnswer.text = ""
        
        if level == 1 {
            level += 1
        } else {
            level -= 1
        }
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
        
    }
    
    func clearAction(action: UIAlertAction) {
        currentUnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
        score -= 1
    }
    
    @objc func clearTapped(_ sender: UIButton){
        currentUnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileURL){
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                    
                    letterButtons.shuffle()
                    
                    if letterButtons.count == letterBits.count {
                        for i in 0..<letterButtons.count {
                            letterButtons[i].setTitle(letterBits[i], for: .normal)
                        }
                    }
                    
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }

}


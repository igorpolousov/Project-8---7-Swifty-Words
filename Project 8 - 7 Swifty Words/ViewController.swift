//
//  ViewController.swift
//  Project 8 - Seven Swifty Words
//  Day 36-37-38
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
    var solutions = [String]() // Массив куда будут добавляться правильные ответы пользователя
    
    // Переменная со свойством наблюдателя. var with observer property
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    
    
    override func loadView() {
        // Задана начальная view на которой будут отображаться все остальные и задан цвет белый
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
        
        // Заданы длина и ширина кнопки в массиве buttonsView
        let width = 150
        let height = 80
        
        // Для каждого ряда число кнопок 4
        for row in 0..<4 {
            // Для каждой колонки число кнопок 5
            for col in 0..<5 {
                // Создали кнопку
                let letterButton = UIButton(type: .system)
                // Указали размер и тип шрифта для кнопки
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                // Установили для каждой кнопки первоначальный title чтобы можно было проверить расположение кнопок
                letterButton.setTitle("WWW", for: .normal)
                // Добавил addTarget с функцией letterTapped
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                // Задан размер рамки для каждой кнопки где указаны координаты и размер кнопки
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                // Кнопке присвоено значение рамки
                letterButton.frame = frame
                // На buttonsView добавлена кнопка
                buttonsView.addSubview(letterButton)
                // Все кнопки добавлены в массив
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.loadLevel()
        }
        
        
    }
    // Функция вызываемая при нажатии кнопки
    @objc func letterTapped(_ sender: UIButton) {
        // Проверка что кнопка содержит title text
        guard let buttonTitle = sender.titleLabel?.text else { return }
        // если проверка пройдена то в текстовое поле добавляется текст с кнопки
        currentUnswer.text = currentUnswer.text?.appending(buttonTitle)
        // Кнопка добавляется в массив нажатых кнопок
        activatedButtons.append(sender)
        // На кнопке скрывается надпись и сама кнопка становится скрыта
        sender.isHidden = true
        
    }
    
    // Функуия вызываемая при нажатии кнопки submit
    @objc func submitTapped(_ sender: UIButton) {
        
        // Проверка что в поле с тектом currentAnswer введен какой-то текст, тогда переменная answerText будет иметь значение строки с введенным текстом
        guard let answerText = currentUnswer.text else { return }
        // Константа, которая определяет индекс введенного слова answerText в массиве solutions. Integer. Если такое слово существует и индекс найден то выполняется, если нет то выполнение строки 228
        if let solutionPosition = solutions.firstIndex(of: answerText){
            // Если проверка пройдена и слово существует, то
            // Из массива нажатых кнопок будет удалены все кнопки
            activatedButtons.removeAll()
            // Создается опциональная переменная которая разделяет ответы пользователя в и ставит из на новую строку. Опциональный массив строк
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            // Добавляем в массив согласно индексу полученному от solutionPosition ответ. То есть добавляется текст на опреденный индекс
            splitAnswers?[solutionPosition] = answerText
            
            // На answerLabel.text добавляется массив ответов разделенных на новую строку. Ответ добавляется на экран
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            // Очистка текстового поля
            currentUnswer.text = ""
            // Добавление очков +1
            score += 1
            // Проверка условия набора 7 очков пользователем для перехода на новый уровень
            if score % 7 == 0 {
                // Если набрал 7 очков показываем алерт
                let ac = UIAlertController(title: "Well done!", message: "You're ready for the next level", preferredStyle: .alert)
                // Добавляем действие levelUp, которое позволяет пользователю перейти на другой уровень
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                // Показали алерт
                present(ac, animated: true)
            }
            
        } else {
            // Если игрок ввел неправильный ответ он получит сообщение очки -1
            let ac = UIAlertController(title: "It's wrong", message: "Entered word is wrong, please press Ok and tap letters again or press Next level to choose another one. Score deducted -1" , preferredStyle: .alert)
            // Предоставляется выбор продолжить или перейти на другой уровень
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: clearAction))
            ac.addAction(UIAlertAction(title: "Next level", style: .default, handler: levelUp))
            // Показли алерт
            present(ac, animated: true)
        }
        
    }
    // Делает переход на другой уровень
    func levelUp(action: UIAlertAction) {
        // Обнулили текст в текстовом поле при переходе на другой уровень
        currentUnswer.text = ""
        
        if level == 1 {
            level += 1
        } else {
            level -= 1
        }
        // удалили все решения
        solutions.removeAll(keepingCapacity: true)
        // Загрузка уровня
        loadLevel()
        // Все кнопки сделали активными
        for button in letterButtons {
            button.isHidden = false
        }
        
    }
    // Функция вызывается если пользователь сделал ошибку
    func clearAction(action: UIAlertAction) {
        currentUnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
        score -= 1
    }
    // Если пользователь сделал ошибку увидел это и хочет удалить набранный текст
    @objc func clearTapped(_ sender: UIButton){
        currentUnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
    // Фукнция запускается когда загружены все view
    @objc func loadLevel() {
        // Строка подсказки
        var clueString = ""
        // Строка решения
        var solutionString = ""
        // Массив компонентов слов(набор букв в слове разделенных символом "|"
        var letterBits = [String]()
        
        // Парсинг уровня  Получение строк из файлов и добавление в массив lines
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileURL){
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                // Метод возвращает последовательность пары констант указынных в цикле. В массиве lines есть слова и каждому слову есть индекс в массиве
                for (index, line) in lines.enumerated() {
                    // Для каждой пары в массиве lines определяем разделитель и присваимваем значение массиву parts
                    let parts = line.components(separatedBy: ": ")
                    // Ответ в этом массиве будет под индексом 0
                    let answer = parts[0]
                    // Подсказка в этом массиве будет под индексом 1
                    let clue = parts[1]
                    // Создаем строку подсказки: номер подсказки с точкой и сама подсказка разделены новой строкой
                    clueString += "\(index + 1). \(clue)\n"
                    // Создаем слово - ответ в котором будут удалены символы "|"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    // Считаем сколько букв в слове ответе
                    solutionString += "\(solutionWord.count) letters\n"
                    // Добавляем слово в массив ответов
                    solutions.append(solutionWord)
                    // Поиск компонентов слов разделенных символом "|"
                    let bits = answer.components(separatedBy: "|")
                    // Добавил в массив кусочков слов кусочки разделенные символом "|"
                    letterBits += bits
                    // Перемешали кнопки в массиве letterButtons
                    letterButtons.shuffle()
                    // Если количество кнопок в массиве равно количествку кусков слов
                    
                    DispatchQueue.main.async {[weak self] in
                        if self?.letterButtons.count == letterBits.count {
                            for i in 0..<self!.letterButtons.count {
                                // Для каждой кнопки с индексом i из массива кнопок установить title из массива кусков слов letterBits с индексом i
                                self?.letterButtons[i].setTitle(letterBits[i], for: .normal)
                            }
                        }
                    }
                    
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            // Задаем текст для подсказок
            self?.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            // Задаем текс для ответов Это либо количество букв либо само слово
            self?.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
    }
    
   

}


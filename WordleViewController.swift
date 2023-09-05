//
//  ViewController.swift
//  Wordle
//
//  Created by Pranav Shidlaghatta on 4/11/22.
//

import UIKit

class WordleViewController: UIViewController {

    @IBOutlet var line1: [UIButton]!
    @IBOutlet var line2: [UIButton]!
    @IBOutlet var line3: [UIButton]!
    @IBOutlet var line4: [UIButton]!
    @IBOutlet var line5: [UIButton]!
    @IBOutlet var line6: [UIButton]!
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var deadLettersLabel: UILabel!
    var count = 1
    let file = "dictionary"
    var answer: String = ""
    var gameState = GameState(ans: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: file, ofType: "txt"){
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                while answer.count != 5 {
                    let randomInt = Int.random(in: 0..<20068)
                    answer = myStrings[randomInt]
                }
            } catch {
                print(error)
            }
        }
        gameState = GameState(ans: answer)
        print("answer = \(gameState.answer)" )
    }
    
    func isCorrect(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

    @IBAction func wordTextField(_ sender: UITextField) {
        if isCorrect(word: sender.text!.lowercased()) == true && sender.text!.count == 5 {
            switch count {
            case 1:
                gameState.populateLine(word: sender.text!, line: line1, deadLetters: deadLettersLabel)
                gameState.currentWord = sender.text!
                //print(sender.text!)
                wordTextField.text = ""
            case 2:
                gameState.populateLine(word: sender.text!, line: line2, deadLetters: deadLettersLabel)
                gameState.currentWord = sender.text!
                wordTextField.text = ""
            case 3:
                gameState.populateLine(word: sender.text!, line: line3, deadLetters: deadLettersLabel)
                gameState.currentWord = sender.text!
                wordTextField.text = ""
            case 4:
                gameState.populateLine(word: sender.text!, line: line4, deadLetters: deadLettersLabel)
                gameState.currentWord = sender.text!
                wordTextField.text = ""
            case 5:
                gameState.populateLine(word: sender.text!, line: line5, deadLetters: deadLettersLabel)
                gameState.currentWord = sender.text!
                wordTextField.text = ""
            case 6:
                gameState.populateLine(word: sender.text!, line: line6, deadLetters: deadLettersLabel)
                gameState.currentWord = sender.text!
                wordTextField.text = ""
            default:
                break
            }
            count += 1
       }
    }
}

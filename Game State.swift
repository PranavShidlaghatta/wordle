//
//  Game State.swift
//  Wordle
//
//  Created by Pranav Shidlaghatta on 4/14/22.
//

import Foundation
import UIKit

class GameState {
    var currentWord: String = ""
    var answer: String
    var currentDictionary: [Character: Int] = [Character: Int]()
    var answerDictionary: [Character: Int] = [Character: Int]()
    var deadLettersArr: [Character] = []
    
    init(ans: String){
        answer = ans
        for c in answer {
            answerDictionary[c] = countAnswerRepeats(letter: String(c))
        }
        print("answer dictionary = \(answerDictionary)")
    }
   
    func populateLine(word: String, line: [UIButton], deadLetters: UILabel){
        currentWord = word
        for c in currentWord {
            currentDictionary[c] = countCurrentLetterRepeats(letter: String(c))
        }
      print("current dictionary = \(currentDictionary)")
        for i in 0...4 {
            let letter = word[i]
            let ansLetter = answer[i]
            highLightGreenAndGrayLetters(box: line[i], letter: letter, ansLetter: ansLetter, cd: currentDictionary)
            line[i].setTitle(String(letter), for: .normal)
            deadLetters.text = deadLettersArr.description
        }
    }
    func highLightYellowLetters(box: UIButton, letter: Character, cd: [Character: Int]){
//        print(answerDictionary)
//        if answerDictionary[letter]! == 0 {
//            box.tintColor = UIColor.gray
//            answerDictionary.removeValue(forKey: letter)
//        }
//        else {
//            print(answerDictionary[letter]!)
//            box.tintColor = .yellow
//            answerDictionary[letter]! -= 1
//        }
        box.tintColor = .yellow
    }
    
    func highLightGreenAndGrayLetters(box: UIButton, letter: Character, ansLetter: Character, cd: [Character: Int]){
        if letter == ansLetter {
            box.tintColor = UIColor.green
            currentDictionary.removeValue(forKey: (letter))
        }
        else if !(answer.contains((letter))){
            deadLettersArr.append(letter)
            box.tintColor = UIColor.gray
            currentDictionary.removeValue(forKey: (letter))
        }
        else { highLightYellowLetters(box: box, letter: letter, cd: cd)}
        
    }
    
    func countCurrentLetterRepeats(letter: String) -> Int{
        var letterCount = 0
        for c in currentWord {
            if c == Character(letter) {
                letterCount += 1
            }
        }
        return letterCount
    }
    
    func countAnswerRepeats(letter: String) -> Int{
        var letterCount = 0
        for c in answer {
            if c == Character(letter) {
                letterCount += 1
            }
        }
        return letterCount
    }
    
    func doesCurrentLetterHashMapContainMoreRepeats(letter: String) -> Bool {
        let currentLetterCount =  currentWord.components(separatedBy: letter)
        let answerLetterCount = answer.components(separatedBy: letter)
        if currentLetterCount.count-1 > answerLetterCount.count-1 { return true }
        return false
    }
    
}
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
